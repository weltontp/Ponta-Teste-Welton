program Agro;

uses
  Vcl.Forms,
  View.Principal in 'View\View.Principal.pas' {FrmPrincipal},
  UDados in 'Dados\UDados.pas' {DmDados: TDataModule},
  View.Fazenda in 'View\View.Fazenda.pas' {FrmFazenda},
  ViewBase in 'Herança\ViewBase.pas' {Base},
  View.Animal in 'View\View.Animal.pas' {FrmAnimal},
  View.Relatorios in 'View\View.Relatorios.pas' {FrmRelatorios};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmPrincipal, FrmPrincipal);
  Application.CreateForm(TDmDados, DmDados);
  Application.CreateForm(TBase, Base);
  Application.Run;
end.
