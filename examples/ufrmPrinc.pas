unit ufrmPrinc;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, JvExControls, JvColorBox,
  JvColorButton, Vcl.ExtCtrls, Vcl.Samples.Spin, Vcl.Imaging.pngimage, Vcl.Imaging.jpeg;

type
  TfrmPrinc = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    mmTexto: TMemo;
    cmbEncoding: TComboBox;
    edtZonaQuieta: TSpinEdit;
    GroupBox1: TGroupBox;
    imgQrCode: TImage;
    cbCorImagem: TJvColorButton;
    cbCorFundo: TJvColorButton;
    btnSalvar: TButton;
    procedure mmTextoChange(Sender: TObject);
    procedure cmbEncodingChange(Sender: TObject);
    procedure edtZonaQuietaChange(Sender: TObject);
    procedure cbCorImagemChange(Sender: TObject);
    procedure cbCorFundoChange(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);

    //Funções para TSaveDialog
    procedure TSaveDialogCanClose(Sender: TObject; var CanClose: Boolean);
    procedure TSaveDialogOnClose(Sender: TObject);
    procedure TSaveDialogTypeChange(Sender: TObject);
  private
    { Private declarations }
   procedure GeraQrCode;
  public
    { Public declarations }
  end;

var
  frmPrinc: TfrmPrinc;

implementation

uses
   uFuncoes, DelphiZXIngQRCode;

{$R *.dfm}

{ TfrmPrinc }

procedure TfrmPrinc.btnSalvarClick(Sender: TObject);
var
   dlgSalvar   : TSaveDialog;
   BMP         : TBitmap;
   JPG         : TJPEGImage;
   sPathFoto   : String;
begin
   try
      dlgSalvar               := TSaveDialog.Create(nil);
      dlgSalvar.OnCanClose    := Self.TSaveDialogCanClose;
      dlgSalvar.OnTypeChange  := Self.TSaveDialogTypeChange;
      dlgSalvar.Filter        := 'JPEG|.jpeg';
      dlgSalvar.Options       := [ofOverWritePrompt, ofPathMustExist, ofCreatePrompt, ofNoLongNames];
      dlgSalvar.InitialDir    := Funcoes.RetornaDiretoriosDefault('%IMAGENS%');
      dlgSalvar.FileName      := 'QRCode';
      if not dlgSalvar.Execute then Exit;
      sPathFoto := Funcoes.RetornaNomeCompletoArquivo(dlgSalvar);
   finally
      FreeAndNil(dlgSalvar);
   end;
   try
      BMP   := TBitmap.Create;
      BMP.Assign(imgQrCode.Picture.Bitmap);

      JPG   := TJPEGImage.Create;
      JPG.CompressionQuality := 100;
      JPG.Assign(TPicture(BMP));
      JPG.Compress;
      JPG.SaveToFile(sPathFoto);
   finally
      FreeAndNil(JPG);
      FreeAndNil(BMP);
   end;
end;

procedure TfrmPrinc.cbCorFundoChange(Sender: TObject);
begin
   GeraQrCode;
end;

procedure TfrmPrinc.cbCorImagemChange(Sender: TObject);
begin
   GeraQrCode;
end;

procedure TfrmPrinc.cmbEncodingChange(Sender: TObject);
begin
   GeraQrCode;
end;

procedure TfrmPrinc.edtZonaQuietaChange(Sender: TObject);
begin
   GeraQrCode;
end;

procedure TfrmPrinc.GeraQrCode;
begin
   imgQrCode.Picture := nil;
   if mmTexto.Lines.Text <> '' then
      Funcoes.GeraQRCode(
         imgQrCode,
         mmTexto.Lines.Text,
         edtZonaQuieta.Value,
         TQRCodeEncoding(cmbEncoding.ItemIndex),
         cbCorImagem.Color, cbCorFundo.Color
      );
end;

procedure TfrmPrinc.mmTextoChange(Sender: TObject);
begin
   GeraQrCode;
end;

procedure TfrmPrinc.TSaveDialogCanClose(Sender: TObject; var CanClose: Boolean);
var Nome,sExt : String;
begin                                   {teste|teste|asd|asd}
   Nome  := TSaveDialog(Sender).FileName;
   sExt  := Funcoes.PegaSeq(TSaveDialog(Sender).Filter,2*TSaveDialog(Sender).FilterIndex);
   if Pos(sExt,Nome)=0 then Nome := Nome + sExt;
   if (FileExists(Nome)) and (ofOverWritePrompt in TSaveDialog(Sender).Options) then
      if Application.MessageBox(PWideChar(Nome+' já existe.'+#13+'Deseja substituí-lo?'),
         'Confirmação',MB_ICONWARNING + MB_YESNO) <> IDYES then begin
         CanClose := False;
      end;
   TSaveDialog(Sender).FileName := Nome;
end;

procedure TfrmPrinc.TSaveDialogOnClose(Sender: TObject);
var Nome,sExt : String;
begin                                   {teste|teste|asd|asd}
   Nome  := TSaveDialog(Sender).FileName;
   sExt  := Funcoes.PegaSeq(TSaveDialog(Sender).Filter,2*TSaveDialog(Sender).FilterIndex);
   if Pos(sExt,Nome)=0 then Nome := Nome + sExt;
   TSaveDialog(Sender).FileName := Nome;
end;

procedure TfrmPrinc.TSaveDialogTypeChange(Sender: TObject);
begin
   TSaveDialog(Sender).DefaultExt := Funcoes.PegaSeq(TSaveDialog(Sender).Filter,2*TSaveDialog(Sender).FilterIndex);
end;

end.
