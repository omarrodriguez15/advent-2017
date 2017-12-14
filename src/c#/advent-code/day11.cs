using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;

namespace advent_code.DayElevenSpace
{
   //6807 too high
   public class Node
   {
      public Node North 
      { 
         get
         { 
            // if (_north == null)
            // {
            //    _north = new Node(Steps + 1)
            //    {
            //       // North = new Node{Steps = Steps + 2},
            //       // NorthEast = new Node{Steps = Steps + 2},
            //       SouthEast = NorthEast,//new Node(Steps + 1),
            //       South = this,
            //       SouthWest = NorthWest
            //       // NorthWest = new Node{Steps = Steps + 2}
            //    };
            // }
            _north.SouthEast = NorthEast;
            _north.South = this;
            _north.SouthWest = NorthWest;
            return _north;
         }
         set{_north = value;}
      }
      public Node NorthEast 
      { 
         get
         { 
            // if (_northEast == null)
            // {
            //    _northEast = new Node(Steps + 1)
            //    {
            //       // North = new Node{Steps = Steps + 2},
            //       // NorthEast = new Node{Steps = Steps + 2},
            //       // SouthEast = new Node{Steps = Steps + 2},
            //       South = SouthEast,
            //       SouthWest = this,
            //       NorthWest = North
            //    };
            // }
            _northEast.South = SouthEast;
            _northEast.SouthWest = this;
            _northEast.NorthWest = North;
            return _northEast;
         }
         set{_northEast = value;}
      }
      public Node SouthEast 
      { 
         get
         { 
            // if (_southEast == null)
            // {
            //    _southEast = new Node(Steps + 1)
            //    {
            //       North = NorthEast,
            //       // NorthEast = new Node{Steps = Steps + 2},
            //       // SouthEast = new Node{Steps = Steps + 2},
            //       // South = new Node{Steps = Steps + 2},
            //       SouthWest = South,
            //       NorthWest = this
            //    };
            // }
            _southEast.North = NorthEast;
            _northEast.SouthWest = South;
            _northEast.NorthWest = this;
            return _southEast;
         }
         set{_southEast = value;}
      }
      public Node South 
      { 
         get
         { 
            // if (_south == null)
            // {
            //    _south = new Node(Steps + 1)
            //    {
            //       North = this,
            //       NorthEast = SouthEast,
            //       // SouthEast = new Node{Steps = Steps + 2},
            //       // South = new Node{Steps = Steps + 2},
            //       // SouthWest = new Node{Steps = Steps + 2},
            //       NorthWest = SouthWest
            //    };
            // }

            _south.North = this;
            _south.NorthEast = SouthEast;
            _south.NorthWest = SouthWest;
            return _south;
         }
         set{_south = value;}
      }
      public Node SouthWest 
      { 
         get
         { 
            // if (_southWest == null)
            // {
            //    _southWest = new Node(Steps + 1)
            //    {
            //       North = NorthWest,
            //       NorthEast = this,
            //       SouthEast = South
            //       // South = new Node{Steps = Steps + 2},
            //       // SouthWest = new Node{Steps = Steps + 2},
            //       // NorthWest = new Node{Steps = Steps + 2}
            //    };
            // }
            _southWest.North = NorthWest;
            _southWest.NorthEast = this;
            _southWest.SouthEast = South;
            return _southWest;
         }
         set{_southWest = value;}
      }
      public Node NorthWest 
      { 
         get
         { 
            // if (_northWest == null)
            // {
            //    _northWest = new Node(Steps + 1)
            //    {
            //       // North = new Node{Steps = Steps + 2},
            //       NorthEast = North,
            //       SouthEast = this,
            //       South = SouthWest
            //       // SouthWest = new Node{Steps = Steps + 2},
            //       // NorthWest = new Node{Steps = Steps + 2}
            //    };
            // }
            _northWest.NorthEast = North;
            _northWest.SouthEast = this;
            _northWest.South = SouthWest;
            return _northWest;
         }
         set{_northWest = value;}
      }

      private Node _north = null;
      private Node _northEast = null;
      private Node _southEast = null;
      private Node _south = null;
      private Node _southWest = null;
      private Node _northWest = null;
      
      public int Steps { get; set; } = 0;
      
      public Node()
      {
      }

      public Node(int steps)
      {
         Steps = steps;
         _north = _north ?? new Node{Steps = steps};
         _northEast = _northEast ?? new Node{Steps = steps};
         _southEast = _southEast ?? new Node{Steps = steps};
         _south = _south ?? new Node{Steps = steps};
         _southWest = _southWest ?? new Node{Steps = steps};
         _northWest = _northWest ?? new Node{Steps = steps};
      }
   }

   public class DayEleven
   {
      public static void DoWork()
      {
         //var directionsStr = File.ReadAllText("../../input/day11.txt");
         //IEnumerable<string> directions = directionsStr.Split(',');
         IEnumerable<string> directions = new List<string>{"ne","ne"};

         // var startNode = new Node
         // {
         //    North = new Node(1),
         //    NorthEast = new Node(1),
         //    SouthEast = new Node(1),
         //    South = new Node(1),
         //    SouthWest = new Node(1),
         //    NorthWest = new Node(1)
         // };
         var startNode = new Node(1);
         var currentNode = startNode;

         foreach(var direction in directions)
         {
            switch(direction)
            {
               case "n":
               currentNode = currentNode.North;
               break;
               case "ne":
               currentNode = currentNode.NorthEast;
               break;
               case "se":
               currentNode = currentNode.SouthEast;
               break;
               case "s":
               currentNode = currentNode.South;
               break;
               case "sw":
               currentNode = currentNode.SouthWest;
               break;
               case "nw":
               currentNode = currentNode.NorthWest;
               break;
            }
         }

         Console.WriteLine($"Steps = {currentNode.Steps}");
      }
   }
}