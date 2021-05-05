unit Dados;

interface

uses
  System.SysUtils, System.Classes, Data.DB, DBAccess, Uni, UniProvider,
  SQLServerUniProvider;

type
  TdmDados = class(TDataModule)
    pvdSqlServer: TSQLServerUniProvider;
    UniCon: TUniConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  dmDados: TdmDados;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TdmDados.DataModuleCreate(Sender: TObject);
begin
  UniCon.Connected:= False;
  UniCon.Connected:= True;
end;

end.
