unit DAO.Banco;

interface

uses DAO.Base, System.JSON, Dados, Data.DB, System.Generics.Collections;

type
  TDAOBanco = class(TDAOBase)
  private

  public
    constructor Create;
    destructor Destroy; override;
    function List(const AQuery: TDictionary<string, string>): TJSONArray;
    function Find(const ACodigo: integer)                   : TJSONObject;
    function Insert(const AValues: TJSONValue)              : TJSONObject;
    function Update(const AValue: TJSONValue)               : TJSONObject;
    function Delete(const ACodigo: integer)                 : TJSONObject;
  end;

implementation

uses
  DataSet.Serialize, System.SysUtils;

{ TDAOBanco }

constructor TDAOBanco.Create;
begin

  inherited Create;
end;

destructor TDAOBanco.Destroy;
begin

  inherited Destroy;
end;

function TDAOBanco.List(const AQuery: TDictionary<string, string>): TJSONArray;
var
  vDataSet: TDataSet;
begin
  try
    with Qry do
    begin
      Close;
      SQL.Add(SelectFrom('BANCO', 'CODIGO, NOME'));

      if AQuery.ContainsKey('since_id') then
      begin
        SQL.Add('AND CODIGO >= :since_id');
        ParamByName('since_id').AsLargeInt := AQuery.Items['since_id'].ToInt64;
      end;

      if AQuery.ContainsKey('max_id') then
      begin
        SQL.Add('AND CODIGO <= :max_id');
        ParamByName('max_id').AsLargeInt := AQuery.Items['max_id'].ToInt64;
      end;
      Open;
    end;

    vDataSet:= Qry;
  finally
    if vDataSet.IsEmpty then
      Result:= TJSONArray.Create
    else
      Result:= vDataSet.ToJSONArray;
    FreeAndNil(Qry);
  end;
end;

function TDAOBanco.Find(const ACodigo: integer): TJSONObject;
var
  JSONBanco: TJSONObject;
  vDataSet: TDataSet;
begin
  try
    with Qry do
    begin
      Close;
      SQL.Add('SELECT T.CODIGO, T.NOME FROM BANCO T WHERE T.CODIGO = :CODIGO');
      ParamByName('CODIGO').AsInteger:= ACodigo;
      Execute;
    end;
    vDataSet:= Qry;

    if vDataSet.IsEmpty then
      Result:= TJSONObject.Create
    else
      Result:= vDataSet.ToJSONObject();
  finally
    FreeAndNil(Qry);
  end;
end;

function TDAOBanco.Insert(const AValues: TJSONValue): TJSONObject;
var
  LCodigo : integer;
  LNome   : string;
begin
  try
    Qry.Close;
    Qry.SQL.Add('INSERT INTO BANCO (CODIGO, NOME) VALUES (:CODIGO, :NOME)');

    LCodigo:= AValues.GetValue<integer>('CODIGO');
    LNome  := AValues.GetValue<string>('NOME');

    Qry.ParamByName('CODIGO').AsInteger:= LCodigo;
    Qry.ParamByName('NOME').AsString:= LNome;
    Qry.Execute;
  finally
    Result:=
      TJSONObject.Create(
        TJSONPair.Create('CODIGO', TJSONNumber.Create(LCodigo))
      );
    FreeAndNil(Qry);
  end;
end;

function TDAOBanco.Update(const AValue: TJSONValue): TJSONObject;
begin

end;

function TDAOBanco.Delete(const ACodigo: integer): TJSONObject;
begin
  try
    Qry.Close;
    Qry.SQL.Add('DELETE FROM BANCO WHERE CODIGO = :CODIGO');
    Qry.ParamByName('CODIGO').AsInteger:= ACodigo;
    Qry.Execute;
  finally
    Result:=
      TJSONObject.Create(
        TJSONPair.Create('CODIGO', TJSONNumber.Create(ACodigo))
      );
    FreeAndNil(Qry);
  end;
end;

end.
