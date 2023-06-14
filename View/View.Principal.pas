unit View.Principal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, ppBands, ppCache, ppClass,
  ppDesignLayer, ppParameter, ppComm, ppRelatv, ppProd, ppReport;

type
  TRelatorio = (rFazenda, rAnimal);

type
  TFrmPrincipal = class(TForm)
    MainMenu1: TMainMenu;
    Cadastro1: TMenuItem;
    Fazenda1: TMenuItem;
    Animal1: TMenuItem;
    Relatrio1: TMenuItem;
    Fazenda2: TMenuItem;
    Animais1: TMenuItem;
    procedure Fazenda1Click(Sender: TObject);
    procedure Animal1Click(Sender: TObject);
    procedure Fazenda2Click(Sender: TObject);
    procedure Animais1Click(Sender: TObject);
  private
    { Private declarations }
    procedure CarregarRelatorio(ARelatorio: TRelatorio);
  public
    FRelatorio: TRelatorio;
    { Public declarations }
  end;

var
  FrmPrincipal: TFrmPrincipal;

implementation
uses
  UDados,
  View.Relatorios,
  View.Animal,
  View.Fazenda;
{$R *.dfm}

procedure TFrmPrincipal.Animais1Click(Sender: TObject);
begin
  Self.CarregarRelatorio(rAnimal);
end;

procedure TFrmPrincipal.Animal1Click(Sender: TObject);
begin
  FrmAnimal := TFrmAnimal.Create(nil);
  try
    FrmAnimal.ShowModal;
  finally
    FreeAndNil(FrmAnimal);
  end;
end;

procedure TFrmPrincipal.CarregarRelatorio(ARelatorio: TRelatorio);
begin
  FrmRelatorios := TFrmRelatorios.Create(nil);
  try
    case ARelatorio of
      rFazenda: begin
        DmDados.cdsFazenda.Close;
        DmDados.cdsFazenda.Open;

        FrmRelatorios.ppRelFazenda.Print;
      end;
      rAnimal: begin
        DmDados.cdsAnimal.Close;
        DmDados.cdsAnimal.Open;

        FrmRelatorios.ppRelAnimal.Print;
      end;
    end;
  finally
    FreeAndNil(FrmRelatorios);
  end;
end;

procedure TFrmPrincipal.Fazenda1Click(Sender: TObject);
begin
  FrmFazenda := TFrmFazenda.Create(nil);
  try
    FrmFazenda.ShowModal;
  finally
    FreeAndNil(FrmFazenda);
  end;
end;

procedure TFrmPrincipal.Fazenda2Click(Sender: TObject);
begin
  Self.CarregarRelatorio(rFazenda);
end;

end.
