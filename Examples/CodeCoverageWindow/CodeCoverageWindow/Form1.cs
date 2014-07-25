using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace CodeCoverageWindow
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            label1.Text = "Button 1 clicked!";
        }

        private void button2_Click(object sender, EventArgs e)
        {
            label1.Text = "Button 2 clicked!";
        }

        private void button3_Click(object sender, EventArgs e)
        {
            label1.Text = "Button 3 clicked!";
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            WebBrowser browser = new WebBrowser();
            if (System.IO.File.Exists(System.IO.Directory.GetCurrentDirectory()+"\\coverage\\index.htm") == true)
            {
                browser.Navigate(System.IO.Directory.GetCurrentDirectory() + "\\coverage\\index.htm");
                panel1.Controls.Add(browser);
                browser.Dock = DockStyle.Fill;
            }
        }
    }
}
