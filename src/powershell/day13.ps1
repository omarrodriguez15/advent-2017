function BuildFirewall{
   Param($content)
   $tempLayers = @{}
   $maxDepth = 0
   $content | %{
      $words = $_.Split(' ')
      $depth = $words[0].Replace(':','')
      $range = $words[1]
      $obj = New-Object PSObject -Property @{
         Depth = [int]$depth;
         Range = [int]$range;
         Position = 0;
         Down = $true;
      }
      $tempLayers.Add([int]$depth, $obj)
      $maxDepth = $depth
   }

   for($i=0; $i -lt ([int]$maxDepth + 1);$i++){
      if(!$tempLayers.ContainsKey([int]$i)){
         
         $obj = New-Object PSObject -Property @{
            Depth = [int]$i;
            Range = 0;
            Position = 0;
            Down = $true;
         }
         $tempLayers.Add([int]$i, $obj)
      }
   }
   $tempLayers
}

function MoveScanner{
   Param($layers)
   for($i=0;$i -lt $layers.Count;$i++){
      $layer = $layers[$i]
      if ($layer.Range -eq 0){
         continue
      }
      if ($layer.Down -and (($layer.Position + 1) -eq $layer.Range)){
         $layer.Down = $false
      }

      if (!$layer.Down -and (($layer.Position - 1) -lt 0)){
         $layer.Down = $true
      }

      if ($layer.Down){
         $layer.Position = ($layer.Position + 1)
      }
      else{
         $layer.Position = ($layer.Position - 1)
      }
   }
   $layers
}

function RidePacket{
   Param($layers)
   $sum = 0
   for($i=0;$i -lt $layers.Count;$i++){
      $layer = $layers[$i]
      if ($layer.Range -gt 0){
         if($layer.Position -eq 0){
            $sum += ($layer.Range * $layer.Depth)
         }
      }
      $layers = MoveScanner $layers
   }
   [int]$sum
}

$content = Get-content "../input/day13.1.txt"
$layers = BuildFirewall $content
RidePacket $layers
# 2164

$delay = 4
$sum = -1

while($sum -ne 0){
   $delay = $delay + 1
   $layers = BuildFirewall $content
   for($i=0; $i -lt $delay;$i++){
      $layers = MoveScanner $layers
   }

   $sum = RidePacket $layers
   # "Sum = $sum"
   # "Delay = $delay"
}
"Delay $delay"