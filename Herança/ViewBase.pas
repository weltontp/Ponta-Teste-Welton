unit ViewBase;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Buttons, Vcl.ExtCtrls, cxGraphics,
  cxControls, cxLookAndFeels, cxLookAndFeelPainters, cxStyles, dxSkinsCore,
  dxSkinBlack, dxSkinBlue, dxSkinBlueprint, dxSkinCaramel, dxSkinCoffee,
  dxSkinDarkroom, dxSkinDarkSide, dxSkinDevExpressDarkStyle,
  dxSkinDevExpressStyle, dxSkinFoggy, dxSkinGlassOceans, dxSkinHighContrast,
  dxSkinLilian, dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin,
  dxSkinMetropolis, dxSkinMetropolisDark, dxSkinMoneyTwins,
  dxSkinOffice2007Black, dxSkinOffice2007Blue, dxSkinOffice2007Green,
  dxSkinOffice2007Pink, dxSkinOffice2007Silver, dxSkinOffice2010Black,
  dxSkinOffice2010Blue, dxSkinOffice2010Silver, dxSkinOffice2013DarkGray,
  dxSkinOffice2013LightGray, dxSkinOffice2013White, dxSkinOffice2016Colorful,
  dxSkinOffice2016Dark, dxSkinOffice2019Colorful, dxSkinPumpkin, dxSkinSeven,
  dxSkinSevenClassic, dxSkinSharp, dxSkinSharpPlus, dxSkinSilver,
  dxSkinSpringtime, dxSkinStardust, dxSkinSummer2008, dxSkinTheAsphaltWorld,
  dxSkinTheBezier, dxSkinsDefaultPainters, dxSkinValentine,
  dxSkinVisualStudio2013Blue, dxSkinVisualStudio2013Dark,
  dxSkinVisualStudio2013Light, dxSkinVS2010, dxSkinWhiteprint,
  dxSkinXmas2008Blue, cxCustomData, cxFilter, cxData, cxDataStorage, cxEdit,
  cxNavigator, dxDateRanges, Data.DB, cxDBData, cxGridLevel, cxClasses,
  cxGridCustomView, cxGridCustomTableView, cxGridTableView, cxGridDBTableView,
  cxGrid, Vcl.ComCtrls, cxContainer, cxTextEdit, cxCurrencyEdit, Vcl.StdCtrls,
  Vcl.ToolWin, System.ImageList, Vcl.ImgList;


type
  TBase = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    cxGrid1: TcxGrid;
    cxGrid1DBTableView1: TcxGridDBTableView;
    cxGrid1Level1: TcxGridLevel;
    Panel2: TPanel;
    Panel1: TPanel;
    GroupBox1: TGroupBox;
    imgList32: TImageList;
    ToolBar1: TToolBar;
    btnIncluir: TToolButton;
    btnAlterar: TToolButton;
    btnExcluir: TToolButton;
    btnCancelar: TToolButton;
    btnSalvar: TToolButton;
    ToolButton1: TToolButton;
    btnAnterior: TToolButton;
    btnProximo: TToolButton;
    ToolButton3: TToolButton;
    btnSelecionar: TToolButton;
    btnSair: TToolButton;
    ToolButton2: TToolButton;
    procedure btnSairClick(Sender: TObject);
    procedure btnIncluirClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnAlterarClick(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure btnAnteriorClick(Sender: TObject);
    procedure btnProximoClick(Sender: TObject);
    procedure btnSelecionarClick(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PageControl1Changing(Sender: TObject; var AllowChange: Boolean);
  private
    { Private declarations }
    procedure ControlButtons(AButton: TToolButton);
  public
    { Public declarations }
    procedure DisableAllMenu;


  end;

var
  Base: TBase;

implementation
uses
  View.Fazenda,
  UDados;

{$R *.dfm}


procedure TBase.btnAlterarClick(Sender: TObject);
begin
  ControlButtons(TToolButton(Sender));
end;

procedure TBase.btnAnteriorClick(Sender: TObject);
begin
  ControlButtons(TToolButton(Sender));
end;

procedure TBase.btnCancelarClick(Sender: TObject);
begin
  ControlButtons(TToolButton(Sender));
end;

procedure TBase.btnExcluirClick(Sender: TObject);
begin
  ControlButtons(TToolButton(Sender));
end;

procedure TBase.btnIncluirClick(Sender: TObject);
begin
  ControlButtons(TToolButton(Sender));
end;

procedure TBase.btnProximoClick(Sender: TObject);
begin
  ControlButtons(TToolButton(Sender));
end;

procedure TBase.btnSairClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TBase.btnSalvarClick(Sender: TObject);
begin
  ControlButtons(TToolButton(Sender));
end;

procedure TBase.btnSelecionarClick(Sender: TObject);
begin
  ModalResult := mrOk;
end;

procedure TBase.ControlButtons(AButton: TToolButton);
begin
  case AButton.Tag of
    0:begin
      GroupBox1.Enabled            := True;
      PageControl1.ActivePageIndex := 1;
      btnIncluir.Enabled           := False;
      btnAlterar.Enabled           := False;
      btnExcluir.Enabled           := False;
      btnCancelar.Enabled          := True;
      btnSair.Enabled              := False;
      btnSalvar.Enabled            := True;
    end;
    1: begin
      GroupBox1.Enabled            := True;
      PageControl1.ActivePageIndex := 1;
      btnIncluir.Enabled           := False;
      btnAlterar.Enabled           := False;
      btnExcluir.Enabled           := False;
      btnCancelar.Enabled          := True;
      btnSair.Enabled              := False;
      btnSalvar.Enabled            := True;
    end;
    2: begin
    end;
    3: begin
      GroupBox1.Enabled            := False;
      btnIncluir.Enabled           := True;
      btnAlterar.Enabled           := True;
      btnExcluir.Enabled           := True;
      btnCancelar.Enabled          := False;
      btnSair.Enabled              := True;
      btnSalvar.Enabled            := False;
    end;
    4: begin
      GroupBox1.Enabled            := False;
      btnIncluir.Enabled           := True;
      btnAlterar.Enabled           := True;
      btnExcluir.Enabled           := True;
      btnCancelar.Enabled          := False;
      btnSair.Enabled              := True;
      btnSalvar.Enabled            := False;
    end;
  end;
  btnAnterior.Enabled              := (not btnCancelar.Enabled);
  btnProximo.Enabled               := (not btnCancelar.Enabled);
end;

procedure TBase.DisableAllMenu;
begin
  for var i := 0 to ComponentCount -1 do
  begin
    if Components[i].ClassType = TToolButton then
      TToolButton(Components[i]).Enabled := False;
  end;
end;

procedure TBase.FormCreate(Sender: TObject);
begin
  PageControl1.ActivePageIndex := 0;
end;


procedure TBase.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 13 then
  begin
    Key := 0;
    Perform(WM_NEXTDLGCTL, 0,0);
  end;
end;

procedure TBase.PageControl1Changing(Sender: TObject; var AllowChange: Boolean);
begin
  AllowChange := (btnCancelar.Enabled = False)
end;

end.
