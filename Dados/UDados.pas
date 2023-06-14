unit UDados;

interface

uses
  Vcl.Forms, Winapi.Windows, System.Variants,
  System.SysUtils, System.Classes, Data.DBXFirebird, Data.FMTBcd, Data.DB,
  Datasnap.DBClient, Datasnap.Provider, Data.SqlExpr;

type
  TDmDados = class(TDataModule)
    Acesso: TSQLConnection;
    sqlFazenda: TSQLQuery;
    dspFazenda: TDataSetProvider;
    cdsFazenda: TClientDataSet;
    dsFazenda: TDataSource;
    cdsFazendaID: TIntegerField;
    cdsFazendaNOME: TStringField;
    sqlAnimal: TSQLQuery;
    dspAnimal: TDataSetProvider;
    cdsAnimal: TClientDataSet;
    dsAnimal: TDataSource;
    cdsAnimalID: TIntegerField;
    cdsAnimalTAG: TStringField;
    cdsAnimalFAZENDA: TIntegerField;
    SQLQuery: TSQLQuery;
    cdsAnimalNOME: TStringField;
    cdsAnimalTemp: TClientDataSet;
    dsAnimalTemp: TDataSource;
    cdsAnimalTempID: TIntegerField;
    cdsAnimalTempTAG: TStringField;
    cdsAnimalTempFAZENDA: TIntegerField;
    cdsAnimalTempNOME: TStringField;
    sqlAnimalID: TIntegerField;
    sqlAnimalTAG: TStringField;
    sqlAnimalFAZENDA: TIntegerField;
    sqlAnimalNOME: TStringField;
    procedure DataModuleCreate(Sender: TObject);
    procedure cdsAnimalTempFAZENDAValidate(Sender: TField);
    procedure cdsAnimalTempBeforeInsert(DataSet: TDataSet);
    procedure cdsAnimalFAZENDAValidate(Sender: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DmDados: TDmDados;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDmDados.cdsAnimalFAZENDAValidate(Sender: TField);
begin
  if VarToStr(Sender.Value) <> EmptyStr then
  begin
    cdsAnimalFAZENDA.OnValidate := nil;
    try
      SQLQuery.Close;
      SQLQuery.SQL.Clear;
      SQLQuery.SQL.Add(Format('select * from fazenda where id = %s', [VarToStr(Sender.Value)]));

      SQLQuery.Open;

      if not SQLQuery.IsEmpty then
      begin
        cdsAnimalfazenda.AsInteger := SQLQuery.FieldByName('id').AsInteger;
        cdsAnimalnome.AsString     := SQLQuery.FieldByName('nome').AsString
      end
      else
      begin
        cdsAnimalNOME.AsString      := EmptyStr;
        cdsAnimalFAZENDA.AsInteger  := 0;
        Application.MessageBox('Fazenda inexistente verifique novamente!','Aviso', MB_ICONINFORMATION + MB_OK);
        Abort;
      end;
    finally
      cdsAnimalFAZENDA.OnValidate := cdsAnimalFAZENDAValidate;
    end;
  end;
end;

procedure TDmDados.cdsAnimalTempBeforeInsert(DataSet: TDataSet);
begin
  if cdsAnimalTemp.RecordCount > 0 then
  begin
    if cdsAnimalTempTAG.AsString = EmptyStr then
    begin
      Application.MessageBox('Informar o campo TAG antes de continuar. Verifique !', 'Aviso', MB_ICONINFORMATION + MB_OK);
      Abort;
    end;

    if cdsAnimalTempFAZENDA.AsInteger <= 0 then
    begin
      Application.MessageBox('Informar a fazenda antes de continuar. Verifique !', 'Aviso', MB_ICONINFORMATION + MB_OK);
      Abort;
    end;
  end;
end;

procedure TDmDados.cdsAnimalTempFAZENDAValidate(Sender: TField);
begin
  cdsAnimalTempFAZENDA.OnValidate := nil;
  try
    SQLQuery.Close;
    SQLQuery.SQL.Clear;
    SQLQuery.SQL.Add(Format('select * from fazenda where id = %s', [VarToStr(Sender.Value)]));

    SQLQuery.Open;

    if not SQLQuery.IsEmpty then
    begin
      cdsAnimalTemp.FieldByName('fazenda').AsInteger := SQLQuery.FieldByName('id').AsInteger;
      cdsAnimalTemp.FieldByName('nome').AsString     := SQLQuery.FieldByName('nome').AsString
    end
    else
    begin
      cdsAnimalTempNOME.AsString      := EmptyStr;
      cdsAnimalTempFAZENDA.AsInteger  := 0;
      Application.MessageBox('Fazenda inexistente verifique novamente!','Aviso', MB_ICONINFORMATION + MB_OK);
      Abort;
    end;
  finally
    cdsAnimalTempFAZENDA.OnValidate := cdsAnimalTempFAZENDAValidate;
  end;

end;

procedure TDmDados.DataModuleCreate(Sender: TObject);
begin
  cdsFazenda.CreateDataSet;
  cdsAnimal.CreateDataSet;
  cdsAnimalTemp.CreateDataSet;

  cdsFazenda.Open;
  cdsAnimal.Open;
  cdsAnimalTemp.Open;
end;

end.
