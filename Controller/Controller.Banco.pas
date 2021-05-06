unit Controller.Banco;

interface

uses
  Horse, System.JSON, System.SysUtils;

  procedure RegisterBanco;
  procedure List(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Find(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Arquivo(Req: THorseRequest; Res: THorseResponse; Next: TProc);
  procedure Arquivo2(Req: THorseRequest; Res: THorseResponse; Next: TProc);

implementation

uses
  Uni, DAO.Banco, System.Classes, System.NetEncoding;

procedure RegisterBanco;
begin
  THorse.Get('/banco'    , List);
  THorse.Get('/banco/:id', Find);
  THorse.Post('/banco'   , Insert);
  THorse.Put('/banco/:id'    , Update);
  THorse.Delete('/banco/:id' , Delete);
  THorse.Get('/arquivo'    , Arquivo);
  THorse.Get('/arquivo2'    , Arquivo2);
end;

procedure List(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  vDAO: TDAOBanco;
  JSONBanco: TJSONArray;
begin
  try
    vDAO:= TDAOBanco.Create;
    JSONBanco:= vDAO.List(Req.Query);
    Res.Send<TJSONArray>(JSONBanco);
  finally
    vDAO.Free;
  end;
end;

procedure Find(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LId: int64;
  vDAO: TDAOBanco;
begin
  try
    vDAO:= TDAOBanco.Create;
    LId:= Req.Params['id'].ToInt64;
    Res.Send<TJSONObject>(vDAO.Find(LId));
  finally
    vDAO.Free;
  end;
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  vDAO: TDAOBanco;
  LJSONRec : TJSONValue;
begin
  if Req.Body.IsEmpty then
    raise Exception.Create('Requisição vazia.');

  try
    vDAO:= TDAOBanco.Create;

    LJSONRec:= TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Req.Body), 0) as TJSONValue;

    Res.Send<TJSONObject>(vDAO.Insert(LJSONRec));
  finally
    LJSONRec.Free;
    vDAO.Free;
  end;
end;


procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  vDAO: TDAOBanco;
  LJSONRec : TJSONValue;
  LId: int64;
begin
  if Req.Body.IsEmpty then
    raise Exception.Create('Requisição vazia.');

  try
    vDAO:= TDAOBanco.Create;

    LJSONRec:= TJSONObject.ParseJSONValue(TEncoding.ASCII.GetBytes(Req.Body), 0) as TJSONValue;
    LId:= Req.Params['id'].ToInt64;
    Res.Send<TJSONObject>(vDAO.Update(LJSONRec, LId));
  finally
    LJSONRec.Free;
    vDAO.Free;
  end;
end;

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LId: int64;
  vDAO: TDAOBanco;
begin
  try
    vDAO:= TDAOBanco.Create;
    LId:= Req.Params['id'].ToInt64;
    Res.Send<TJSONObject>(vDAO.Delete(LId));
  finally
    vDAO.Free;
  end;
end;

procedure Arquivo(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LStream   : TStringStream;
  LStreamOut: TStringStream;
  LJson     : TJSONArray;
begin
  LStream:= TStringStream.Create;
  try
    LStream.LoadFromFile('D:\Programas\Server_Horse\relatorios\novo.pdf');
    LStream.Position := 0;

    LStreamOut := TStringStream.Create;
    TNetEncoding.Base64.Encode(LStream, LStreamOut);
    LJSon := TJSONArray.Create('Arquivo', LStreamOut.DataString);

    Res.Send<TJSONArray>(LJSon);
  finally
    LStream.Free;
    LStreamOut.Free;
  end;
end;

procedure Arquivo2(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LStream : TStream;
begin
  LStream:= TFileStream.Create('D:\Programas\Server_Horse\relatorios\novo.pdf', fmOpenRead);
  Res.Send<TStream>(LStream);
end;

end.
