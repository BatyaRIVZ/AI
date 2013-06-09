unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ScktComp;

type
  TForm1 = class(TForm)
    Timer1: TTimer;
    Memo1: TMemo;
    Edit1: TEdit;
    procedure FormActivate(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ClientRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure FormCreate(Sender: TObject);
    procedure Edit1Enter(Sender: TObject);

  private
    { Private declarations }
  public
    procedure input(s:string);
    procedure output(s:string);
  end;

var
  Form1: TForm1;
implementation

uses suzie;

{$R *.dfm}

procedure TForm1.input(s: string);
begin
suzie.parce(s);
end;

procedure TForm1.output(s: string);
begin
memo1.Lines.Add('< '+s);
end;

procedure TForm1.ClientRead(Sender: TObject; Socket: TCustomWinSocket);
begin
memo1.Lines.Add('< '+socket.ReceiveText);
end;

procedure TForm1.Edit1Enter(Sender: TObject);
var
Layout: array[0.. KL_NAMELENGTH] of char;
begin
LoadKeyboardLayout( StrCopy(Layout,'00000419'),KLF_ACTIVATE);
end;

procedure TForm1.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key = vk_return then
begin
memo1.Lines.Add('> '+edit1.text);
input(edit1.text);
edit1.Text := '';
end;
end;

procedure TForm1.FormActivate(Sender: TObject);
var
  r : TRect;
begin
  SystemParametersInfo(SPI_GETWORKAREA, 0, Addr(r), 0);
  Form1.Left := r.Right-form1.Width-5;
  Form1.Top := r.Bottom-form1.Height-5;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
suzie.init;
end;

end.
