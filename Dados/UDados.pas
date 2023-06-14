unit UDados;

interface

uses
  Vcl.Forms, Winapi.Windows,
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
    procedure cdsAnimalTempBeforePost(DataSet: TDataSet);
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

procedure TDmDados.cdsAnimalTempBeforePost(DataSet: TDataSet);
begin
  if cdsAnimalTemp.FieldByName('tag').IsNull then
    Application.MessageBox('Informar o campo TAG antes de continuar. Verifique !', 'Aviso', MB_ICONINFORMATION + MB_OK);
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
