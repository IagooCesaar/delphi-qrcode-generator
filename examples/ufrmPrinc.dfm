object frmPrinc: TfrmPrinc
  Left = 0
  Top = 0
  Caption = 'Gerador de QR Code'
  ClientHeight = 378
  ClientWidth = 712
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = 'Calibri'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 15
  object Label1: TLabel
    Left = 8
    Top = 8
    Width = 240
    Height = 15
    Caption = 'Informe o texto a ser codificado no QR Code'
  end
  object Label2: TLabel
    Left = 455
    Top = 8
    Width = 107
    Height = 15
    Caption = 'Tipo de codifica'#231#227'o'
  end
  object Label3: TLabel
    Left = 455
    Top = 53
    Width = 88
    Height = 15
    Caption = 'Margem interna'
  end
  object Label4: TLabel
    Left = 606
    Top = 8
    Width = 82
    Height = 15
    Caption = 'Cor da imagem'
  end
  object Label5: TLabel
    Left = 606
    Top = 53
    Width = 71
    Height = 15
    Caption = 'Cor do fundo'
  end
  object mmTexto: TMemo
    Left = 8
    Top = 24
    Width = 441
    Height = 69
    ScrollBars = ssVertical
    TabOrder = 0
    OnChange = mmTextoChange
  end
  object cmbEncoding: TComboBox
    Left = 455
    Top = 24
    Width = 145
    Height = 23
    Style = csDropDownList
    ItemIndex = 0
    TabOrder = 1
    Text = 'Autom'#225'tico'
    OnChange = cmbEncodingChange
    Items.Strings = (
      'Autom'#225'tico'
      'Num'#233'rico'
      'Alfanum'#233'rico'
      'ISO-8859-1'
      'UTF-8 sem BOM'
      'UTF-8 com BOM')
  end
  object edtZonaQuieta: TSpinEdit
    Left = 455
    Top = 69
    Width = 145
    Height = 24
    MaxValue = 0
    MinValue = 0
    TabOrder = 2
    Value = 1
    OnChange = edtZonaQuietaChange
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 99
    Width = 688
    Height = 235
    Caption = ':: Visualiza'#231#227'o do QRCode'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Calibri'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 3
    object imgQrCode: TImage
      AlignWithMargins = True
      Left = 245
      Top = 25
      Width = 202
      Height = 202
      Margins.Left = 8
      Margins.Top = 6
      Margins.Right = 8
      Margins.Bottom = 8
      Center = True
    end
  end
  object cbCorImagem: TJvColorButton
    Left = 606
    Top = 24
    Width = 90
    Height = 23
    OtherCaption = '&Other...'
    Options = []
    OnChange = cbCorImagemChange
    TabOrder = 4
  end
  object cbCorFundo: TJvColorButton
    Left = 606
    Top = 69
    Width = 90
    Height = 24
    OtherCaption = '&Other...'
    Options = []
    Color = clWhite
    OnChange = cbCorFundoChange
    TabOrder = 5
  end
  object btnSalvar: TButton
    Left = 601
    Top = 340
    Width = 95
    Height = 27
    Cursor = crHandPoint
    Caption = '&Salvar'
    TabOrder = 6
    OnClick = btnSalvarClick
  end
end
