unit View.Animal;

interface

uses
  Data.DBXCommon,
  UDados,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ViewBase, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges, Data.DB, cxDBData,
  System.ImageList, Vcl.ImgList, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls,
  Vcl.ExtCtrls, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Vcl.Buttons, Vcl.Mask, Vcl.DBCtrls,
  cxButtonEdit, Vcl.Grids, Vcl.DBGrids;

type
  TFrmAnimal = class(TBase)
    cxGrid1DBTableView1ID: TcxGridDBColumn;
    cxGrid1DBTableView1TAG: TcxGridDBColumn;
    cxGrid1DBTableView1FAZENDA: TcxGridDBColumn;
    cxGrid1DBTableView1NOME: TcxGridDBColumn;
    Label1: TLabel;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    BitBtn1: TBitBtn;
    DBEdit4: TDBEdit;
    cxGrid2: TcxGrid;
    cxGridAnimalTemp: TcxGridDBTableView;
    cxGridLevel1: TcxGridLevel;
    cxGridAnimalTempTAG: TcxGridDBColumn;
    cxGridAnimalTempFAZENDA: TcxGridDBColumn;
    cxGridAnimalTempNOME: TcxGridDBColumn;
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnAnteriorClick(Sender: TObject);
    procedure btnProximoClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure cxGridAnimalTempFAZENDAPropertiesValidate(Sender: TObject;
      var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
    procedure cxGridAnimalTempFAZENDAPropertiesButtonClick(Sender: TObject;
      AButtonIndex: Integer);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure DBEdit3Exit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAnimal: TFrmAnimal;

implementation
uses
  View.Fazenda;

{$R *.dfm}

procedure TFrmAnimal.BitBtn1Click(Sender: TObject);
begin
  inherited;

  FrmFazenda := TFrmFazenda.Create(nil);
  try
    FrmFazenda.DisableAllMenu;
    FrmFazenda.btnSelecionar.Enabled := True;

    DmDados.cdsFazenda.Close;
    DmDados.cdsFazenda.Open;

    if FrmFazenda.ShowModal = mrOk then
    begin
      DmDados.cdsAnimalTempFAZENDA.AsInteger := DmDados.cdsFazendaID.AsInteger;
      DmDados.cdsAnimalTempNOME.AsString     := DmDados.cdsFazendaNOME.AsString;
    end;
  finally
    FreeAndNil(FrmFazenda);
  end;
end;

procedure TFrmAnimal.btnAlterarClick(Sender: TObject);
begin
  inherited;

  DmDados.cdsAnimal.Edit;

  cxGrid2.Visible := False;
  DBEdit2.SetFocus;
end;

procedure TFrmAnimal.btnAnteriorClick(Sender: TObject);
begin
  inherited;
  DmDados.cdsAnimal.Prior;
end;

procedure TFrmAnimal.btnCancelarClick(Sender: TObject);
begin
  inherited;
  DmDados.cdsAnimal.Cancel;
  DmDados.cdsAnimalTemp.Cancel;
  DmDados.cdsAnimalTemp.EmptyDataSet;
end;

procedure TFrmAnimal.btnIncluirClick(Sender: TObject);
begin
  inherited;
  cxGrid2.Visible := True;

  DmDados.cdsAnimalTemp.EmptyDataSet;
  DmDados.cdsAnimalTemp.Append;

  cxGrid2.SetFocus;
  Application.MessageBox('Este processo poder� incluir um (1) ou mais de um registro no grid, ao clicar em "Salvar" todos os registro incluidos ser�o salvos no banco!', 'Aviso', MB_ICONINFORMATION + MB_OK);
end;

procedure TFrmAnimal.btnProximoClick(Sender: TObject);
begin
  inherited;
  DmDados.cdsAnimal.Next;
end;

procedure TFrmAnimal.btnSalvarClick(Sender: TObject);

  function NewCodigo: Integer;
  const
    COMMANDTEXT = 'select gen_id(gen_animal, 1) as newcodigo from RDB$DATABASE';
  begin
    DmDados.sqlQuery.Close;
    DmDados.sqlQuery.SQL.Clear;
    DmDados.sqlQuery.SQL.Add(COMMANDTEXT);
    DmDados.sqlQuery.open;

    Result := DmDados.sqlQuery.FieldByName('newcodigo').AsInteger;
  end;

var
  Trans: TDBXTransaction;
begin
  inherited;
  if (DmDados.cdsAnimalTemp.RecordCount > 0) and (DmDados.cdsAnimal.State = dsBrowse) then
  begin
    Trans := DmDados.Acesso.BeginTransaction;
    try
      DmDados.cdsAnimalTemp.First;
      while not DmDados.cdsAnimalTemp.Eof do
      begin
        DmDados.cdsAnimal.Append;

        DmDados.cdsAnimalID.AsInteger      := NewCodigo;
        DmDados.cdsAnimalTAG.AsString      := DmDados.cdsAnimalTempTAG.AsString;
        DmDados.cdsAnimalFAZENDA.AsInteger := DmDados.cdsAnimalTempFAZENDA.AsInteger;

        DmDados.cdsAnimal.Post;

        DmDados.cdsAnimalTemp.Next;
      end;
      if DmDados.cdsAnimal.ApplyUpdates(0) = 0 then
      begin
        DmDados.Acesso.CommitFreeAndNil(Trans);
        Application.MessageBox('Todos os registros foram gravados com sucesso !', 'Aviso', MB_ICONINFORMATION + MB_OK)
      end
      else
      begin
        DmDados.Acesso.RollbackFreeAndNil(Trans);
        Application.MessageBox('Houve falhas ao gravar os registros.', 'Aviso', MB_ICONINFORMATION + MB_OK);
      end;
    finally
      if Assigned(Trans) then
        FreeAndNil(Trans);
    end;
  end
  else
  if DmDados.cdsAnimal.State = dsEdit then
  begin
    DmDados.cdsAnimal.Post;
    DmDados.cdsAnimal.ApplyUpdates(0);
  end;
end;

procedure TFrmAnimal.cxGridAnimalTempFAZENDAPropertiesButtonClick(
  Sender: TObject; AButtonIndex: Integer);
begin
  inherited;
  FrmFazenda := TFrmFazenda.Create(nil);
  try
    FrmFazenda.DisableAllMenu;
    FrmFazenda.btnSelecionar.Enabled := True;

    DmDados.cdsFazenda.Close;
    DmDados.cdsFazenda.Open;

    if FrmFazenda.ShowModal = mrOk then
    begin
      DmDados.cdsAnimalTempFAZENDA.AsInteger := DmDados.cdsFazendaID.AsInteger;
      DmDados.cdsAnimalTempNOME.AsString     := DmDados.cdsFazendaNOME.AsString;
    end;
  finally
    FreeAndNil(FrmFazenda);
  end;
end;

procedure TFrmAnimal.cxGridAnimalTempFAZENDAPropertiesValidate(Sender: TObject;
  var DisplayValue: Variant; var ErrorText: TCaption; var Error: Boolean);
begin
  inherited;

  DmDados.SQLQuery.Close;
  DmDados.SQLQuery.SQL.Clear;
  DmDados.SQLQuery.SQL.Add(Format('select * from fazenda where id = %s', [VarToStr(DisplayValue)]));

  DmDados.SQLQuery.Open;

  if not DmDados.SQLQuery.IsEmpty then
  begin
    DmDados.cdsAnimalTemp.FieldByName('fazenda').AsInteger := DmDados.SQLQuery.FieldByName('id').AsInteger;
    DmDados.cdsAnimalTemp.FieldByName('nome').AsString     := DmDados.SQLQuery.FieldByName('nome').AsString
  end
  else
  begin
    DmDados.cdsAnimalTempNOME.AsString      := EmptyStr;
    DmDados.cdsAnimalTempFAZENDA.AsInteger  := 0;
  end;
end;

procedure TFrmAnimal.DBEdit3Exit(Sender: TObject);
begin
  inherited;

  DmDados.SQLQuery.Close;
  DmDados.SQLQuery.SQL.Clear;
  DmDados.SQLQuery.SQL.Add(Format('select * from fazenda where id = %s', [TDBEdit(Sender).Text]));

  DmDados.SQLQuery.Open;

  if not DmDados.SQLQuery.IsEmpty then
  begin
    DmDados.cdsAnimalFAZENDA.AsInteger := DmDados.SQLQuery.FieldByName('id').AsInteger;
    DmDados.cdsAnimalNOME.AsString     := DmDados.SQLQuery.FieldByName('nome').AsString
  end
  else
  begin
    DmDados.cdsAnimalTempNOME.AsString      := EmptyStr;
    DmDados.cdsAnimalTempFAZENDA.AsInteger  := 0;
  end;
end;

procedure TFrmAnimal.FormShow(Sender: TObject);
begin
  inherited;
  DmDados.cdsAnimal.Close;
  DmDados.cdsAnimal.Open;
end;

end.