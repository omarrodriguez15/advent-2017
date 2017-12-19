using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace advent_code.d112
{
   //307 , 531, 
   // y / 2 + 1
   public class DayEleven
   {
      public static void DoWork()
      {
         var directionsStr = File.ReadAllText("../../input/day11.txt");
         IEnumerable<string> directions = directionsStr.Split(',');
         //IEnumerable<string> directions = new List<string>{"sw","ne","s"};
         var maxSteps = int.MinValue;
         var xSteps = 0;
         var ySteps = 0;
         foreach(var direction in directions)
         {
            switch(direction)
            {
               case "n":
               ySteps += 2;
               break;
               case "ne":
               xSteps += 1;
               ySteps += 1;
               break;
               case "se":
               xSteps += 1;
               ySteps -= 1;
               break;
               case "s":
               ySteps -= 2;
               break;
               case "sw":
               xSteps -= 1;
               ySteps -= 1;
               break;
               case "nw":
               xSteps -= 1;
               ySteps += 1;
               break;
            }
            maxSteps = Math.Max(maxSteps, GetNumberOfStepsFromPos(xSteps, ySteps));
         }
         
         var steps = GetNumberOfStepsFromPos(xSteps, ySteps);
         Console.WriteLine($"Location x={xSteps} y={ySteps}");
         Console.WriteLine($"Least number of steps={steps}");
         Console.WriteLine($"Max number of steps={maxSteps}");
      }

      public static int GetNumberOfStepsFromPos(int x, int y)
      {
         return (Math.Abs(x) / 2) + (Math.Abs(y) / 2);
      }
   }
}