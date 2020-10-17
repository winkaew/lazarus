program project1;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  Classes,opensslsockets,
  fpjson,fphttpclient,jsonparser;

var
   jobj:TJSONObject;
   jArr:TJSONArray;
   jEnum:TJSONEnum;
   response:String;

begin
  jArr:=TJSONArray.Create;
  try
   //response:=TFPCustomHTTPClient.SimpleGet('https://jsonplaceholder.typicode.com/posts');
   response:=TFPCustomHTTPClient.SimpleGet('https://jsonplaceholder.typicode.com/users');
   writeln(response);

   jArr:= GetJSON(response) as TJSONArray;
   for jEnum in jArr do begin
     jobj:=jEnum.Value as TJSONObject;

     //WriteLn(jobj.Strings['title']+ ' ::');
     WriteLn('::'+ jobj.Strings['name']+ '::');
    //WriteLn(jobj.Strings['body']);
    WriteLn(jobj.FindPath('email').AsString);
    WriteLn(jobj.Objects['address'].Strings['street']);
    WriteLn(jobj.Objects['address'].Strings['city']);
    WriteLn(jobj.Objects['address'].Strings['zipcode']);
    WriteLn(jobj.Objects['address'].Objects['geo'].Strings['lat']);
    WriteLn(jobj.Objects['address'].Objects['geo'].Strings['lng']);


    WriteLn(jobj.FindPath('address.street').AsString);
    WriteLn(jobj.FindPath('address.city').AsString);
    WriteLn(jobj.FindPath('address.zipcode').AsString);
    WriteLn(jobj.FindPath('address.geo.lat').AsString);
    WriteLn(jobj.FindPath('address.geo.lng').AsString);

    if jobj.FindPath('address.geo.lng') <> nil
    then
    WriteLn(jobj.FindPath('address.geo.lng').AsString;

   end;
  finally
    jArr.Free;
  end;
end.

