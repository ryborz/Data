using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using NUnit.Framework;

namespace CodeCoverageconsole
{
    [TestFixture]
    class Program
    {
        static int a = 1;
        static int b = 2;

        static void Main(string[] args)
        {
        }

        [Test]
        public static void Test1()
        {
            if (a == 1)
            {
            }
        }

        [Test]
        public static void Test2()
        {
            if (b == 3)
            {
                a = 2;
            }
            else
            {
                a = 3;
            }
        }
    }
}
