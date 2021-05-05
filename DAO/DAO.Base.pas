unit DAO.Base;

interface

uses
  Uni;

type
  TDAOBase = class
  private
    FConexao: TUniConnection;
    FQry: TUniQuery;
  public
    property Conexao: TUniConnection read FConexao write FConexao;
    property Qry: TUniQuery read FQry write FQry;
    constructor Create;
    destructor Destroy; override;
    function SelectFrom(ATabela: string; AColuna: string): string;
    function InsertInto(ATabela: string; AColuna: string; AValue: string): string;
    function QuotedCommaStr(AText: string): string;
  end;

implementation

{ TDAOBase }

uses
  Dados, System.SysUtils, System.Classes;

constructor TDAOBase.Create;
begin
  FConexao       := dmDados.UniCon;
  FQry           := TUniQuery.Create(nil);
  FQry.Connection:= FConexao;
end;

destructor TDAOBase.Destroy;
begin
  FreeAndNil(FQry);
  inherited;
end;

function TDAOBase.InsertInto(ATabela, AColuna, AValue: string): string;
begin

end;

function TDAOBase.SelectFrom(ATabela: string; AColuna: string): string;
begin
  Result:= Format('SELECT %s FROM %s WHERE 1 = 1',[AColuna, ATabela]);
end;

function TDAOBase.QuotedCommaStr(AText: string): string;
 var
  Tstr : TStrings;
  i : integer;
begin
  Tstr := TStringList.Create;
  Tstr.CommaText := StringReplace(AText,' ','[C_ESPACO]',[rfReplaceAll]);

  for i := 0 to Tstr.Count - 1 do
    Tstr[i] := Quotedstr(Tstr[i]);

  Result := Tstr.CommaText;
  Result := StringReplace(Result,'[C_ESPACO]',' ',[rfReplaceAll]);
  Tstr.Free;
end;

end.
