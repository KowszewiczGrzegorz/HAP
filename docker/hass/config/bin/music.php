#!/usr/bin/php
<?php
error_reporting(E_ERROR | E_WARNING | E_PARSE);

function send_to_yamaha($host, $data=''){
  $fp = fsockopen($host, 80) or die("Unable to open socket");
  $buf = "";

  fputs($fp, "POST /YamahaRemoteControl/ctrl HTTP/1.1\r\n");
  fputs($fp, "Host: $host\r\n");
  fputs($fp, "Content-type: text/plain\r\n");
  fputs($fp, "Content-length: " . strlen($data) . "\r\n");
  fputs($fp, "Connection: close\r\n\r\n");
  fputs($fp, $data);

  while (!feof($fp))
    $buf .= fgets($fp, 1024);

  fclose($fp);
  return $buf;
}

function send_raw($host, $port, $data=''){
  $fp = fsockopen($host, $port) or die("Unable to open socket");
  $buf = "";
  fputs($fp, $data);
  fclose($fp);
  return $buf;
}

$akcja=$argv[1];
$source=$argv[2];
if($akcja == "") { $akcja = "play"; }
if($source == "") { $source = "AUDIO1"; }


if($akcja == "play") {
// turn on music
$command = '<YAMAHA_AV cmd="PUT">
<Main_Zone><Power_Control><Power>On</Power></Power_Control></Main_Zone>
<Zone_2><Power_Control><Power>On</Power></Power_Control></Zone_2></YAMAHA_AV>';
$comm = send_to_yamaha('10.0.0.24', $command);

// wait, set source and volume
sleep(8);
$command = '<YAMAHA_AV cmd="PUT">
<System><Party_Mode><Mode>On</Mode></Party_Mode></System>
<Main_Zone><Input><Input_Sel>'.$source.'</Input_Sel></Input></Main_Zone>
<Main_Zone><Volume><Lvl><Val>-550</Val><Exp>1</Exp><Unit>dB</Unit></Lvl></Volume></Main_Zone>
<Zone_2><Volume><Lvl><Val>-450</Val><Exp>1</Exp><Unit>dB</Unit></Lvl></Volume></Zone_2></YAMAHA_AV>';
$comm = send_to_yamaha('10.0.0.24',$command);

// play on samsung
if($source == "AUDIO1") {
  $command = "samsung $akcja\r\n";
  $command .= "samsung mixer volume 70\r\n";
  $comm = send_raw("10.0.0.11", "9090", $command);
  $command = '<YAMAHA_AV cmd="PUT">
<System><Party_Mode><Mode>On</Mode></Party_Mode></System>
<Main_Zone><Input><Input_Sel>'.$source.'</Input_Sel></Input></Main_Zone>
<Main_Zone><Volume><Lvl><Val>-140</Val><Exp>1</Exp><Unit>dB</Unit></Lvl></Volume></Main_Zone>
<Zone_2><Volume><Lvl><Val>-175</Val><Exp>1</Exp><Unit>dB</Unit></Lvl></Volume></Zone_2></YAMAHA_AV>';
  $comm = send_to_yamaha('10.0.0.24',$command);
 }
}

if($akcja == "stop") {
// stop music
$command = '<YAMAHA_AV cmd="PUT">
<Main_Zone><Power_Control><Power>Standby</Power></Power_Control></Main_Zone>
<Zone_2><Power_Control><Power>Standby</Power></Power_Control></Zone_2></YAMAHA_AV>';
$comm = send_to_yamaha('10.0.0.24', $command);

// wlacz play na samsungu, ktory jest sparowany z garazem?
if($source == "AUDIO1") {
  $command = "samsung $akcja\r\n";
  $comm = send_raw("10.0.0.11", "9090", $command);
 }
}

die();
?>
