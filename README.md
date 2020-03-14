# delphi-qrcode-generator
Gerador de QR Code simples e dinâmico

• Disponibilizada função prática para geração de QR Codes. 

Para seu funcionamento serão necessários os seguintes parâmetros:

  • var imgDestino : TImage
  Neste compomente que será inserido o QR Code a ser gerado
  
  • Data : String
  Este é o conteúdo que irá compor o "corpo" do QR Code
  
  • QuietZone : Integer = 4;
  "Zonas quietas" são utilizadas como a margem interna do QR Code
  A resposta padrão é 4
  
  • Encoding : TQRCodeEncoding = qrAuto
  Tipo de Encoding do conteúdo do corpo do QR Code
  A resposta padrão é "Automático"
  
  • CorPreto : Integer = clBlack
  Cor principal do QR Code
  
  • CorBranco : Integer = clWhite
  Cor secundária do QR Code
  
  
  É importante ressaltar que a função "Funcoes.GeraQRCode" é de minha autoria, no entanto os componentes que esta função depende é de autoria de terceiros.
  
  
