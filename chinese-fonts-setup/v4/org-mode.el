;;; `cfs--custom-set-fontsnames' 列表有3个子列表，第1个为英文字体列表，第2个为中文字体列表，
;;; 第3个列表中的字体用于显示不常用汉字，每一个字体列表中，*第一个* *有效并可用* 的字体将被使用。
;;; 将光标移动到上述列表中，按 `C-c C-c' 可以测试字体显示效果。另外，用户可以通过命令
;;; `cfs-insert-fontname’ 来选择一个 *可用* 字体，然后在当前光标处插入其字体名称。
(setq cfs--custom-set-fontnames
      '(
        ("Monaco" "Consolas" "DejaVu Sans Mono" "Droid Sans Mono" "PragmataPro" "Ubuntu Mono" "Liberation Mono" "MonacoB" "MonacoB2" "MonacoBSemi" "Droid Sans Mono Pro" "Inconsolata" "Lucida Console" "Envy Code R" "Andale Mono" "Lucida Sans Typewriter" "monoOne" "Lucida Typewriter" "Panic Sans" "Hack" "Bitstream Vera Sans Mono" "HyperFont" "PT Mono" "Ti92Pluspc" "Excalibur Monospace" "Menlof" "Cousine" "Fira Mono" "Lekton" "M+ 1mn" "BPmono" "Free Mono" "Anonymous Pro" "ProFont" "ProFontWindows" "Latin Modern Mono" "Code 2002" "ProggyCleanTT" "ProggyTinyTT" "Courier" "Courier New" "Source Code Pro")
        ("微软雅黑" "方正兰亭黑_GBK" "方正兰亭准黑_GBK" "文泉驿等宽微米黑" "方正书宋简体" "方正字迹-典雅楷体简体" "方正宋刻本秀楷简体" "方正正纤黑简体" "方正清刻本悦宋简体" "方正苏新诗柳楷简体" "冬青黑体简体中文 W6" "文泉驿等宽正黑" "思源黑体 Regular" "思源黑体 Normal" "思源黑体 Heavy" "文泉驿点阵正黑" "文泉驿正黑" "冬青黑体简体中文 W3" "YouYuan" "Noto Sans S Chinese Regular" "Microsoft_Yahei" "Ubuntu Mono" "黑体" "Microsoft Yahei" "SimHei" "SimSun" "NSimSun" "FangSong" "KaiTi" "FangSong_GB2312" "KaiTi_GB2312" "LiSu" "新宋体" "宋体" "楷体_GB2312" "仿宋_GB2312" "幼圆" "隶书" "STXihei" "STKaiti" "STSong" "STZhongsong" "STFangsong" "FZShuTi" "FZYaoti" "STCaiyun" "STHupo" "STLiti" "STXingkai" "STXinwei" "方正姚体" "方正舒体" "方正粗圆_GBK" "华文仿宋" "华文中宋" "华文彩云" "华文新魏" "华文细黑" "华文行楷" "冬青黑体" "思源黑体" "思源黑体 Medium" "思源黑体 Light" "思源黑体 ExtraLight" "思源黑体 Bold" "Hiragino Sans GB" "文泉驿微米黑" "方正兰亭纤黑_GBK" "Microsoft YaHei UI")
        ("HanaMinB" "SimSun-ExtB" "MingLiU-ExtB" "PMingLiU-ExtB" "MingLiU_HKSCS-ExtB")
        ))

;;; `cfs--custom-set-fontsizes' 中，所有元素的结构都类似：(英文字号 中文字号 EXT-B字体字号)
;;; 将光标移动到各个数字上，按 C-c C-c 查看光标处字号的对齐效果。
;;; 按 C-<up> 增大光标处字号，按 C-<down> 减小光标处字号。
(setq cfs--custom-set-fontsizes
      '(
        (9    10.5 10.5)
        (10   12.0 12.0)
        (11.5 13.5 13.5)
        (12.5 15.0 15.0)
        (14   16.5 16.5)
        (16   19.5 19.5)
        (18   21.0 21.0)
        (20   24.0 24.0)
        (22   25.5 25.5)
        (24   28.5 28.5)
        (26   31.5 31.5)
        (28   33.0 33.0)
        (30   36.0 36.0)
        (32   39.0 39.0)
        ))
