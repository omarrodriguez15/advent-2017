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
         $mapOfPipesToZero.Add([int]$pipe.Name, 0)
         $pipe.Pipes | %{
            if(!$mapOfPipesToZero.ContainsKey([int]$_)){
               $mapOfPipesToZero.Add([int]$_, 0)
            }
         }
      }
      else{
         if ($mapOfPipesToZero.ContainsKey([int]$pipe.Name)){
            $numOfPipes += 1
            $pipe.Pipes | %{
               if(!$mapOfPipesToZero.ContainsKey([int]$_)){
                  $mapOfPipesToZero.Add([int]$_, 0)
               }
            }
         }
         else {
            $pipe.Pipes | %{
               if ($mapOfPipesToZero.ContainsKey([int]$_)){
                  $numOfPipes += 1
                  $pipe.Pipes | %{
                     if(!$mapOfPipesToZero.ContainsKey([int]$_)){
                        $mapOfPipesToZero.Add([int]$_, 0)
                     }
                  }
                  if(!$mapOfPipesToZero.ContainsKey([int]$pipe.Name)){
                     $mapOfPipesToZero.Add([int]$pipe.Name, 0)
                  }
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