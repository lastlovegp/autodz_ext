namespace MdTZ
{
    partial class MainFrm
    {
        /// <summary>
        /// 必需的设计器变量。
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// 清理所有正在使用的资源。
        /// </summary>
        /// <param name="disposing">如果应释放托管资源，为 true；否则为 false。</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows 窗体设计器生成的代码

        /// <summary>
        /// 设计器支持所需的方法 - 不要
        /// 使用代码编辑器修改此方法的内容。
        /// </summary>
        private void InitializeComponent()
        {
            this.components = new System.ComponentModel.Container();
            this.menuStrip1 = new System.Windows.Forms.MenuStrip();
            this.历史数据ToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripSeparator1 = new System.Windows.Forms.ToolStripSeparator();
            this.新闻分析ToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.要闻刷新ToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.实时数据ToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.新闻获取ToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.个股公告ToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.新闻后处理ToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.同花顺加入自选ToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.财务数据ToolStripMenuItem = new System.Windows.Forms.ToolStripMenuItem();
            this.toolStripMenuItem1 = new System.Windows.Forms.ToolStripMenuItem();
            this.gp_buys_Time = new System.Windows.Forms.Timer(this.components);
            this.groupBox1 = new System.Windows.Forms.GroupBox();
            this.txt_log = new System.Windows.Forms.TextBox();
            this.txt_url = new System.Windows.Forms.TextBox();
            this.cb_new_type = new System.Windows.Forms.ComboBox();
            this.label1 = new System.Windows.Forms.Label();
            this.get_filter_timer = new System.Windows.Forms.Timer(this.components);
            this.gp_sells_timer = new System.Windows.Forms.Timer(this.components);
            this.gp_web = new System.Windows.Forms.WebBrowser();
            this.label2 = new System.Windows.Forms.Label();
            this.cmb_gp_sel = new System.Windows.Forms.ComboBox();
            this.button1 = new System.Windows.Forms.Button();
            this.button2 = new System.Windows.Forms.Button();
            this.menuStrip1.SuspendLayout();
            this.groupBox1.SuspendLayout();
            this.SuspendLayout();
            // 
            // menuStrip1
            // 
            this.menuStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.历史数据ToolStripMenuItem,
            this.实时数据ToolStripMenuItem});
            this.menuStrip1.Location = new System.Drawing.Point(0, 0);
            this.menuStrip1.Name = "menuStrip1";
            this.menuStrip1.Size = new System.Drawing.Size(471, 25);
            this.menuStrip1.TabIndex = 0;
            this.menuStrip1.Text = "menuStrip1";
            // 
            // 历史数据ToolStripMenuItem
            // 
            this.历史数据ToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.toolStripSeparator1,
            this.新闻分析ToolStripMenuItem,
            this.要闻刷新ToolStripMenuItem});
            this.历史数据ToolStripMenuItem.Name = "历史数据ToolStripMenuItem";
            this.历史数据ToolStripMenuItem.Size = new System.Drawing.Size(68, 21);
            this.历史数据ToolStripMenuItem.Text = "历史数据";
            // 
            // toolStripSeparator1
            // 
            this.toolStripSeparator1.Name = "toolStripSeparator1";
            this.toolStripSeparator1.Size = new System.Drawing.Size(121, 6);
            // 
            // 新闻分析ToolStripMenuItem
            // 
            this.新闻分析ToolStripMenuItem.Name = "新闻分析ToolStripMenuItem";
            this.新闻分析ToolStripMenuItem.Size = new System.Drawing.Size(124, 22);
            this.新闻分析ToolStripMenuItem.Text = "新闻分析";
            this.新闻分析ToolStripMenuItem.Click += new System.EventHandler(this.新闻分析ToolStripMenuItem_Click);
            // 
            // 要闻刷新ToolStripMenuItem
            // 
            this.要闻刷新ToolStripMenuItem.Name = "要闻刷新ToolStripMenuItem";
            this.要闻刷新ToolStripMenuItem.Size = new System.Drawing.Size(124, 22);
            this.要闻刷新ToolStripMenuItem.Text = "要闻刷新";
            this.要闻刷新ToolStripMenuItem.Click += new System.EventHandler(this.要闻刷新ToolStripMenuItem_Click);
            // 
            // 实时数据ToolStripMenuItem
            // 
            this.实时数据ToolStripMenuItem.DropDownItems.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.新闻获取ToolStripMenuItem,
            this.个股公告ToolStripMenuItem,
            this.新闻后处理ToolStripMenuItem,
            this.同花顺加入自选ToolStripMenuItem,
            this.财务数据ToolStripMenuItem,
            this.toolStripMenuItem1});
            this.实时数据ToolStripMenuItem.Name = "实时数据ToolStripMenuItem";
            this.实时数据ToolStripMenuItem.Size = new System.Drawing.Size(68, 21);
            this.实时数据ToolStripMenuItem.Text = "实时数据";
            // 
            // 新闻获取ToolStripMenuItem
            // 
            this.新闻获取ToolStripMenuItem.Name = "新闻获取ToolStripMenuItem";
            this.新闻获取ToolStripMenuItem.Size = new System.Drawing.Size(160, 22);
            this.新闻获取ToolStripMenuItem.Text = "新闻获取";
            this.新闻获取ToolStripMenuItem.Click += new System.EventHandler(this.新闻获取ToolStripMenuItem_Click);
            // 
            // 个股公告ToolStripMenuItem
            // 
            this.个股公告ToolStripMenuItem.Name = "个股公告ToolStripMenuItem";
            this.个股公告ToolStripMenuItem.Size = new System.Drawing.Size(160, 22);
            this.个股公告ToolStripMenuItem.Text = "个股公告";
            this.个股公告ToolStripMenuItem.Click += new System.EventHandler(this.个股公告ToolStripMenuItem_Click);
            // 
            // 新闻后处理ToolStripMenuItem
            // 
            this.新闻后处理ToolStripMenuItem.Name = "新闻后处理ToolStripMenuItem";
            this.新闻后处理ToolStripMenuItem.Size = new System.Drawing.Size(160, 22);
            this.新闻后处理ToolStripMenuItem.Text = "新闻后处理";
            this.新闻后处理ToolStripMenuItem.Click += new System.EventHandler(this.新闻后处理ToolStripMenuItem_Click);
            // 
            // 同花顺加入自选ToolStripMenuItem
            // 
            this.同花顺加入自选ToolStripMenuItem.Name = "同花顺加入自选ToolStripMenuItem";
            this.同花顺加入自选ToolStripMenuItem.Size = new System.Drawing.Size(160, 22);
            this.同花顺加入自选ToolStripMenuItem.Text = "同花顺加入自选";
            this.同花顺加入自选ToolStripMenuItem.Click += new System.EventHandler(this.同花顺加入自选ToolStripMenuItem_Click);
            // 
            // 财务数据ToolStripMenuItem
            // 
            this.财务数据ToolStripMenuItem.Name = "财务数据ToolStripMenuItem";
            this.财务数据ToolStripMenuItem.Size = new System.Drawing.Size(160, 22);
            this.财务数据ToolStripMenuItem.Text = "财务数据";
            this.财务数据ToolStripMenuItem.Click += new System.EventHandler(this.财务数据ToolStripMenuItem_Click_1);
            // 
            // toolStripMenuItem1
            // 
            this.toolStripMenuItem1.Name = "toolStripMenuItem1";
            this.toolStripMenuItem1.Size = new System.Drawing.Size(160, 22);
            this.toolStripMenuItem1.Text = "交易接口";
            this.toolStripMenuItem1.Click += new System.EventHandler(this.toolStripMenuItem1_Click);
            // 
            // gp_buys_Time
            // 
            this.gp_buys_Time.Interval = 5000;
            this.gp_buys_Time.Tick += new System.EventHandler(this.gp_buys_Time_Tick);
            // 
            // groupBox1
            // 
            this.groupBox1.Controls.Add(this.txt_log);
            this.groupBox1.Dock = System.Windows.Forms.DockStyle.Bottom;
            this.groupBox1.Location = new System.Drawing.Point(0, 184);
            this.groupBox1.Name = "groupBox1";
            this.groupBox1.Size = new System.Drawing.Size(471, 162);
            this.groupBox1.TabIndex = 1;
            this.groupBox1.TabStop = false;
            this.groupBox1.Text = "日志信息";
            // 
            // txt_log
            // 
            this.txt_log.Dock = System.Windows.Forms.DockStyle.Fill;
            this.txt_log.Location = new System.Drawing.Point(3, 17);
            this.txt_log.Multiline = true;
            this.txt_log.Name = "txt_log";
            this.txt_log.ScrollBars = System.Windows.Forms.ScrollBars.Horizontal;
            this.txt_log.Size = new System.Drawing.Size(465, 142);
            this.txt_log.TabIndex = 1;
            // 
            // txt_url
            // 
            this.txt_url.Location = new System.Drawing.Point(187, 29);
            this.txt_url.Name = "txt_url";
            this.txt_url.Size = new System.Drawing.Size(278, 21);
            this.txt_url.TabIndex = 2;
            // 
            // cb_new_type
            // 
            this.cb_new_type.FormattingEnabled = true;
            this.cb_new_type.Items.AddRange(new object[] {
            "新闻联播",
            "IPO收益",
            "业绩快报",
            "业绩预增",
            "业绩预披",
            "个股公告",
            "今日头条-同花顺",
            "今日要闻",
            "创新低",
            "创新高",
            "向上突波",
            "向下突波",
            "大众交易",
            "大单追踪",
            "异动观察",
            "持续放量",
            "持续缩量",
            "新股申购",
            "早盘必读",
            "机会情报",
            "概念资金",
            "行业资金",
            "财经要闻",
            "财经要闻-同花顺",
            "连续上涨",
            "连续下跌",
            "送股派息",
            "量价齐升",
            "量较齐跌",
            "限售解禁",
            "险资举牌",
            "首页-同花顺",
            "高管持股"});
            this.cb_new_type.Location = new System.Drawing.Point(60, 30);
            this.cb_new_type.Name = "cb_new_type";
            this.cb_new_type.Size = new System.Drawing.Size(121, 20);
            this.cb_new_type.TabIndex = 3;
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(12, 33);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(41, 12);
            this.label1.TabIndex = 4;
            this.label1.Text = "分类：";
            // 
            // get_filter_timer
            // 
            this.get_filter_timer.Interval = 12000;
            this.get_filter_timer.Tick += new System.EventHandler(this.get_filter_timer_Tick);
            // 
            // gp_sells_timer
            // 
            this.gp_sells_timer.Interval = 5000;
            this.gp_sells_timer.Tick += new System.EventHandler(this.gp_sells_timer_Tick);
            // 
            // gp_web
            // 
            this.gp_web.Location = new System.Drawing.Point(378, 56);
            this.gp_web.MinimumSize = new System.Drawing.Size(20, 20);
            this.gp_web.Name = "gp_web";
            this.gp_web.ScriptErrorsSuppressed = true;
            this.gp_web.Size = new System.Drawing.Size(87, 23);
            this.gp_web.TabIndex = 2;
            this.gp_web.Url = new System.Uri("", System.UriKind.Relative);
            this.gp_web.Visible = false;
            this.gp_web.DocumentCompleted += new System.Windows.Forms.WebBrowserDocumentCompletedEventHandler(this.gp_web_DocumentCompleted);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(10, 61);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(65, 12);
            this.label2.TabIndex = 10;
            this.label2.Text = "选股策略：";
            // 
            // cmb_gp_sel
            // 
            this.cmb_gp_sel.FormattingEnabled = true;
            this.cmb_gp_sel.Items.AddRange(new object[] {
            "自选股",
            "全部自选",
            "利好股",
            "龙头股",
            "异动观察",
            "昨日大涨",
            "横盘多头",
            "大波动",
            "行业优势",
            "概念优势",
            "优质股",
            "创业板"});
            this.cmb_gp_sel.Location = new System.Drawing.Point(86, 56);
            this.cmb_gp_sel.Name = "cmb_gp_sel";
            this.cmb_gp_sel.Size = new System.Drawing.Size(121, 20);
            this.cmb_gp_sel.TabIndex = 9;
            // 
            // button1
            // 
            this.button1.Location = new System.Drawing.Point(213, 56);
            this.button1.Name = "button1";
            this.button1.Size = new System.Drawing.Size(75, 23);
            this.button1.TabIndex = 8;
            this.button1.Text = "选股生成";
            this.button1.UseVisualStyleBackColor = true;
            this.button1.Click += new System.EventHandler(this.button1_Click);
            // 
            // button2
            // 
            this.button2.Location = new System.Drawing.Point(313, 146);
            this.button2.Name = "button2";
            this.button2.Size = new System.Drawing.Size(75, 23);
            this.button2.TabIndex = 11;
            this.button2.Text = "人工智能";
            this.button2.UseVisualStyleBackColor = true;
            this.button2.Click += new System.EventHandler(this.button2_Click);
            // 
            // MainFrm
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(471, 346);
            this.Controls.Add(this.button2);
            this.Controls.Add(this.label2);
            this.Controls.Add(this.cmb_gp_sel);
            this.Controls.Add(this.button1);
            this.Controls.Add(this.gp_web);
            this.Controls.Add(this.label1);
            this.Controls.Add(this.cb_new_type);
            this.Controls.Add(this.txt_url);
            this.Controls.Add(this.menuStrip1);
            this.Controls.Add(this.groupBox1);
            this.MainMenuStrip = this.menuStrip1;
            this.MaximumSize = new System.Drawing.Size(487, 384);
            this.MinimumSize = new System.Drawing.Size(487, 384);
            this.Name = "MainFrm";
            this.Text = "量化投资";
            this.Load += new System.EventHandler(this.MainFrm_Load);
            this.menuStrip1.ResumeLayout(false);
            this.menuStrip1.PerformLayout();
            this.groupBox1.ResumeLayout(false);
            this.groupBox1.PerformLayout();
            this.ResumeLayout(false);
            this.PerformLayout();

        }

        #endregion

        private System.Windows.Forms.MenuStrip menuStrip1;
        private System.Windows.Forms.ToolStripMenuItem 历史数据ToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem 实时数据ToolStripMenuItem;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator1;
        private System.Windows.Forms.Timer gp_buys_Time;
        private System.Windows.Forms.GroupBox groupBox1;
        private System.Windows.Forms.ToolStripMenuItem 新闻获取ToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem 个股公告ToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem 新闻后处理ToolStripMenuItem;
        private System.Windows.Forms.TextBox txt_url;
        private System.Windows.Forms.ComboBox cb_new_type;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.ToolStripMenuItem 新闻分析ToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem 要闻刷新ToolStripMenuItem;
        private System.Windows.Forms.Timer get_filter_timer;
        private System.Windows.Forms.Timer gp_sells_timer;
        private System.Windows.Forms.TextBox txt_log;
        private System.Windows.Forms.WebBrowser gp_web;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.ComboBox cmb_gp_sel;
        private System.Windows.Forms.Button button1;
        private System.Windows.Forms.ToolStripMenuItem 同花顺加入自选ToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem 财务数据ToolStripMenuItem;
        private System.Windows.Forms.ToolStripMenuItem toolStripMenuItem1;
        private System.Windows.Forms.Button button2;
    }
}