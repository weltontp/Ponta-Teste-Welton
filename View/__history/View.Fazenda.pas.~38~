unit View.Fazenda;

interface

uses
  UDados,
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, ViewBase, cxGraphics, cxControls,
  cxLookAndFeels, cxLookAndFeelPainters, cxStyles, cxCustomData, cxFilter,
  cxData, cxDataStorage, cxEdit, cxNavigator, dxDateRanges, Data.DB, cxDBData,
  System.ImageList, Vcl.ImgList, Vcl.ComCtrls, Vcl.ToolWin, Vcl.StdCtrls,
  Vcl.ExtCtrls, cxGridLevel, cxClasses, cxGridCustomView, cxGridCustomTableView,
  cxGridTableView, cxGridDBTableView, cxGrid, Vcl.Mask, Vcl.DBCtrls;

type
  TFrmFazenda = class(TBase)
    Label1: TLabel;
    DBEdit1: TDBEdit;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    cxGrid1DBTableView1ID: TcxGridDBColumn;
    cxGrid1DBTableView1NOME: TcxGridDBColumn;
    procedure btnIncluirClick(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnAnteriorClick(Sender: TObject);
    procedure btnProximoClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmFazenda: TFrmFazenda;

implementation

{$R *.dfm}

procedure TFrmFazenda.btnAlterarClick(Sender: TObject);
begin
  inherited;
  DmDados.cdsFazenda.Edit;
  DBEdit2.SetFocus;
end;

procedure TFrmFazenda.btnAnteriorClick(Sender: TObject);
begin
  inherited;
  DmDados.cdsFazenda.Prior;
end;

procedure TFrmFazenda.btnCancelarClick(Sender: TObject);
begin
  inherited;
  DmDados.cdsFazenda.Cancel;
end;

procedure TFrmFazenda.btnExcluirClick(Sender: TObject);
begin
  inherited;
  if not DmDados.cdsFazenda.IsEmpty then
  begin
    if Application.MessageBox(PChar(Format('Deseja realmente excluir a fazenda: "%s"', [DmDados.cdsFazendaNOME.AsString])), 'Aviso', MB_ICONQUESTION + MB_YESNO) = ID_YES then
      DmDados.cdsFazenda.Delete;
  end
  else
    Application.MessageBox('Não existem registros para excluir. Verifique !', 'Aviso', MB_ICONINFORMATION + MB_OK)
end;

procedure TFrmFazenda.btnIncluirClick(Sender: TObject);
begin
  inherited;
  DmDados.cdsFazenda.Append;
  DBEdit2.SetFocus;
end;

procedure TFrmFazenda.btnProximoClick(Sender: TObject);
begin
  inherited;
  DmDados.cdsFazenda.Next;
end;

procedure TFrmFazenda.btnSalvarClick(Sender: TObject);

  function ExistesNome: Boolean;
  const
    COMMANDTEXT = 'select count(*) as total from fazenda where (nome = %s)';
  begin
    DmDados.sqlQuery.Close;
    DmDados.sqlQuery.SQL.Clear;
    DmDados.sqlQuery.SQL.Add(Format(COMMANDTEXT, [QuotedStr(DmDados.cdsFazendaNOME.AsString)]));
    DmDados.sqlQuery.open;

    Result := (DmDados.sqlQuery.FieldByName('TOTAL').AsInteger > 0);
  end;

const
  COMMANDTEXT = 'select gen_id(gen_fazenda, 1) as newcodigo from RDB$DATABASE';
begin
  inherited;

  if DmDados.cdsFazenda.State = dsInsert then
  begin
    if ExistesNome then
    begin
      Application.MessageBox(PChar(Format('Já existe uma fazenda chamada: "%s". O processo será encerrado!', [DmDados.cdsFazendaNOME.AsString])), 'Aviso', MB_ICONINFORMATION + MB_OK);
      DmDados.cdsFazenda.Cancel;
      Exit;
    end
    else
    begin
      DmDados.sqlQuery.Close;
      DmDados.sqlQuery.SQL.Clear;
      DmDados.sqlQuery.SQL.Add(COMMANDTEXT);
      DmDados.sqlQuery.open;

      DmDados.cdsFazendaID.AsInteger := DmDados.sqlQuery.FieldByName('newcodigo').AsInteger;
    end;
  end;


  DmDados.cdsFazenda.Post;
  DmDados.cdsFazenda.ApplyUpdates(-1)

end;

procedure TFrmFazenda.FormShow(Sender: TObject);
begin
  inherited;
  DmDados.cdsFazenda.Close;
  DmDados.cdsFazenda.Open;
end;

end.
