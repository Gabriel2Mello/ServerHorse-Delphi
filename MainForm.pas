unit MainForm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TMainFrm = class(TForm)
    memLog: TMemo;
    Panel1: TPanel;
    Label1: TLabel;
    edtUsuario: TEdit;
    edtPorta: TEdit;
    edtSenha: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    btnIniciar: TButton;
    btnParar: TButton;
    procedure FormCreate(Sender: TObject);
    procedure btnIniciarClick(Sender: TObject);
    procedure btnPararClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure StartApplication;
    procedure StopApplication;
  end;

var
  MainFrm: TMainFrm;

implementation

{$R *.dfm}

uses Horse, Horse.Paginate, Horse.Compression, Horse.Jhonson, Horse.Commons,
     Horse.BasicAuthentication, Horse.OctetStream, Horse.HandleException,
     Controller.Banco, System.JSON, Horse.Etag;

procedure TMainFrm.btnIniciarClick(Sender: TObject);
begin
  StartApplication;
end;

procedure TMainFrm.btnPararClick(Sender: TObject);
begin
  StopApplication;
end;

procedure TMainFrm.FormCreate(Sender: TObject);
begin
  ReportMemoryLeaksOnShutdown:= True;
  THorse
  .Use(Compression())
  .Use(Jhonson())
  .Use(Paginate)
  .Use(HandleException)
  .Use(OctetStream);
  //.Use(Etag);

//  THorse.Use(HorseBasicAuthentication(
//  function(const AUsername, APassword: string): Boolean
//  begin
//    Result:= AUsername.Equals(edtUsuario.Text) and APassword.Equals(edtSenha.Text);
//  end));

  RegisterBanco;
end;

procedure TMainFrm.StartApplication;
begin
  THorse.Listen(StrToIntDef(edtPorta.Text, 9000), procedure(Horse: THorse)
  begin
    memLog.Lines.Add('Servidor ouvindo na porta: ' + Horse.Port.ToString);
    memLog.Lines.Add(DateTimeToStr(Now));
  end);

end;

procedure TMainFrm.StopApplication;
begin
  THorse.StopListen;
  memLog.Lines.Add('Servidor parou na porta: ' + StrToIntDef(edtPorta.Text, 9000).ToString);
  memLog.Lines.Add(DateTimeToStr(Now));
  memLog.Lines.Add(' ');
end;

end.
