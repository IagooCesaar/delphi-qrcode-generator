unit uFuncoes;

interface

uses DelphiZXingQRCode, Classes, SysUtils, Vcl.StdCtrls, Vcl.ExtCtrls,
   Windows, Winapi.ShellAPI, Winapi.ShlObj, Vcl.Dialogs,
   Vcl.Imaging.pngimage, Vcl.Imaging.jpeg, Vcl.Graphics;

type
   { Funcoes }
   Funcoes = class(TObject)
      private

      public
         class function  PegaSeq(Texto : String; posicao : Integer;sep : String = '|') : String;
         class procedure GeraQRCode(var imgDestino : TImage; Data : String;
            QuietZone : Integer = 4; Encoding : TQRCodeEncoding = qrAuto;
            CorPreto : Integer = clBlack; CorBranco : Integer = clWhite);
         class function  RetornaDiretoriosDefault(Local : String) : String;
         class function  RetornaNomeCompletoArquivo(savedlg : TSaveDialog) : String;
   end;

implementation


{ Funcoes }

class procedure Funcoes.GeraQRCode(var imgDestino: TImage; Data: String;
  QuietZone: Integer; Encoding: TQRCodeEncoding; CorPreto, CorBranco: Integer);
var
   QRCode  :TDelphiZXingQRCode;
   QRCodeBitmap: TBitmap;
   Row, Column: Integer;
   Scale : Double;
begin
   try
      QRCode            := TDelphiZXingQRCode.Create;
      QRCode.Data       := Data;
      QRCode.Encoding   := Encoding;
      QRCode.QuietZone  := QuietZone;

      QRCodeBitmap      := TBitmap.Create;
      QRCodeBitmap.SetSize(QRCode.Rows, QRCode.Columns);
      for Row := 0 to QRCode.Rows-1 do begin
         for Column := 0 to QRCode.Columns-1 do begin
            if QRCode.IsBlack[Row, Column] then
               QRCodeBitmap.Canvas.Pixels[Column, Row]   := CorPreto
            else
               QRCodeBitmap.Canvas.Pixels[Column, Row]   := CorBranco;
         end;
      end;
      imgDestino.Picture            := nil;
      imgDestino.Canvas.Brush.Color := clWhite;
      imgDestino.Canvas.FillRect(Rect(0,0,imgDestino.Width, imgDestino.Height));
      if (QRCodeBitmap.Width>0) and (QRCodeBitmap.Height>0) then begin
         if imgDestino.Width < imgDestino.Height then
            Scale := imgDestino.Width  / QRCodeBitmap.Width
         else
            Scale := imgDestino.Height / QRCodeBitmap.Height;
         imgDestino.Canvas.StretchDraw(
            Rect(0,0, Trunc(Scale * QRCodeBitmap.Width), Trunc(Scale * QRCodeBitmap.Height)),
            QRCodeBitmap
         );
      end;
   finally
      QRCode.Free;
      QRCodeBitmap.Free;
   end;
end;

class function Funcoes.PegaSeq(Texto: String; posicao: Integer;
  sep: String): String;
// Retorna a string n de uma sequencia do tipo: 23,78,58,90 ou 10|25|52|58
// Exemplo: pegaseq(tipo,2) = 78
var sl : TStringList;
begin
   try
      sl := TStringList.Create;
      sl.StrictDelimiter := True;
      sl.Delimiter       := Sep[1];
      sl.DelimitedText   := Texto;
      if (sl.Count) < posicao then
         Result := ''
      else
         Result := sl.Strings[Posicao-1];
   finally
      FreeAndNil(sl);
   end;
end;

class function Funcoes.RetornaDiretoriosDefault(Local: String): String;
var
   InFolder : array[0..MAX_PATH] of Char;
   PIDL : PItemIDList;
begin
   if Pos('%DESKTOP%',Local) > 0 then begin
      { Get the desktop location }
      SHGetSpecialFolderLocation(0, CSIDL_DESKTOPDIRECTORY, PIDL);
      SHGetPathFromIDList(PIDL, InFolder);
   end else
   if Pos('%STARTMENU%',Local) > 0 then begin
      SHGetSpecialFolderLocation(0, CSIDL_STARTMENU, PIDL);
      //CSIDL_STARTMENU CSIDL_STARTUP
      SHGetPathFromIDList(PIDL, InFolder);
   end else
   if Pos('%APPDATA%',Local) > 0 then begin
      SHGetSpecialFolderLocation(0, CSIDL_APPDATA, PIDL);
      SHGetPathFromIDList(PIDL, InFolder);
   end else
   if Pos('%DOCUMENTOS%',Local) > 0 then begin
      SHGetSpecialFolderLocation(0, CSIDL_MYDOCUMENTS, PIDL);
      SHGetPathFromIDList(PIDL, InFolder);
   end else
   if Pos('%IMAGENS%',Local) > 0 then begin
      SHGetSpecialFolderLocation(0, CSIDL_MYPICTURES, PIDL);
      SHGetPathFromIDList(PIDL, InFolder);
   end else
   if Pos('%PERFIL%',Local) > 0 then begin
      SHGetSpecialFolderLocation(0, CSIDL_PROFILE, PIDL);
      SHGetPathFromIDList(PIDL, InFolder);
   end else
   if Pos('%PROGRAFILESX86%',Local) > 0 then begin
      SHGetSpecialFolderLocation(0, CSIDL_PROGRAM_FILESX86, PIDL);
      SHGetPathFromIDList(PIDL, InFolder);
   end else
   if Pos('%PROGRAFILESX64%',Local) > 0 then begin
      SHGetSpecialFolderLocation(0, CSIDL_PROGRAM_FILES, PIDL);
      SHGetPathFromIDList(PIDL, InFolder);
   end;
   Result := InFolder;
end;

class function Funcoes.RetornaNomeCompletoArquivo(savedlg: TSaveDialog): String;
begin
   Result := savedlg.FileName+savedlg.DefaultExt;
end;

end.
