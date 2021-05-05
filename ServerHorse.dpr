program ServerHorse;

uses
  Vcl.Forms,
  MainForm in 'MainForm.pas' {MainFrm},
  Dados in 'Dados.pas' {dmDados: TDataModule},
  DAO.Base in 'DAO\DAO.Base.pas',
  Controller.Banco in 'Controller\Controller.Banco.pas',
  DAO.Banco in 'DAO\DAO.Banco.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TdmDados, dmDados);
  Application.CreateForm(TMainFrm, MainFrm);
  Application.Run;
end.
