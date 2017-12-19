function GetPipes {
   Param($content)
   $pipes = @()
   
   $content | %{
      $isLinkedToZero = $false
      $words = $_.Split(' ')
      $name = $words[0]

      if($name -eq 0){
         $isLinkedToZero = $true
      }

      $pipeList = @()
      for ($i=2;$i -lt $words.Count; $i++){
         $pipeName = $words[$i].Replace(',','')
         $pipeList += $pipeName
      }

      $pipes += New-Object PSObject –Property @{
         Name = $name;
         Pipes = $pipeList;
         IsLinkedToZero = $isLinkedToZero
      }
   }
   $pipes
}

function HowManyPipeToZero{
   Param($pipes)
   $numOfPipes = 0
   $mapOfPipesToZero = @{}

   $pipes | %{
      $pipe = $_
      if($pipe.IsLinkedToZero){
         $numOfPipes += 1
         $mapOfPipesToZero.Add($pipe.Name, 0)
         $pipe.Pipes | %{
            if(!$mapOfPipesToZero.ContainsKey($_)){
               $mapOfPipesToZero.Add($_, 0)
            }
         }
      }
      else{
         if ($mapOfPipesToZero.ContainsKey($pipe.Name)){
            $numOfPipes += 1
            $pipe.Pipes | %{
               if(!$mapOfPipesToZero.ContainsKey($_)){
                  $mapOfPipesToZero.Add($_, 0)
               }
            }
         }
      }
   }

   $numOfPipes
}

$content = Get-content "../input/day12.txt"

$pipes = GetPipes $content
HowManyPipeToZero $pipes
# 6