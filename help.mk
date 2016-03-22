  h=@echo
 nl=$(h)
#---------------------------------------------------------------------
help:
	$(nl)
	$(h) "本次试验是为了了解gcc/ld链接器的工作过程,区别.a和.so文件,"
	$(h) "根具make不同的目标,测试不同的功能!"
	$(nl)
	$(h) "make main-na"
	$(h) "   # 使用非完整的库libdemo-n.a(缺少show.o调用util_init()接口"
	$(h) "   # 的实现util.o),这种方法是直接加载.a文件中被调用接口所在"
	$(h) "   # 的.o文件.这个例子中main.c只调用了print.c的print_init(),"
	$(h) "   # 故只要libdemo-n.a中有print.o即可,即使show.c文件中有调用"
	$(h) "   # util.c中的util_init().由此可知,ld是按需连接的!"
	$(nl)
	$(h) "make main-nc"
	$(h) "   # 使用完整的库libdemo-c.a,和make main-na没有本质的区别,"
	$(h) "   # main-ca与main-na大小一致!"
	$(nl)
	$(h) "make main-sna"
	$(h) "   # 使用非完整的库libdemo-n.a生成静态目标文件,符号引用亦是"
	$(h) "   # 按需查找符号表."
	$(nl)
	$(h) "make main-sca"
	$(h) "   # 使用完整的库libdemo-c.a,和make main-sna没有本质的区别,"
	$(h) "   # main-sca与main-sna大小一致!"
	$(nl)
	$(h) "make main-lna"
	$(h) "   # 使用非完整的库libdemo-n.a并且通过\"-l\"选项来查找"
	$(h) "   # libdemo-n.a"
	$(nl)
	$(h) "make main-lca"
	$(h) "   # 使用完整的库libdemo-n.a并且通过\"-l\"选项来查找"
	$(h) "   # libdemo-c.a"
	$(nl)
	$(h) "make main-ns"
	$(h) "   # 直接使用非完整的libdemo-n.so,编译失败!!!原因是libdemo-n.so"
	$(h) "   # 缺少符号util_init的信息,导致show_init的依赖不完整;由此"
	$(h) "   # 看来,so文件只有一个符号表并且需要一个完整的依赖关系,而"
	$(h) "   # a文件只是一些o文件的集合,每个o文件有自己的符号表."
	$(nl)
	$(h) "make main-cs"
	$(h) "   # 直接使用完整的libdemo-c.so,编译成功!so文件中每个符号都"
	$(h) "   # 有完整的依赖链,运行时需要libdemo-c.so库,可通过环境变亮"
	$(h) "   # LD_LIBRARY_PATH指定libdemo-c.so的路径."
	$(nl)
	$(h) "make main-scs"
	$(h) "   # 静态链接不能链接动态库!"
	$(nl)
	$(h) "make main-lcs"
	$(h) "   # 通过\"-l\"选项来寻找指定的库,根具ld手册,先寻找libxxx.so"
	$(h) "   # 文件,如果不存在则查找libxxx.a文件;ld会根具不同的后缀进"
	$(h) "   # 行不同的处理."
	$(nl)
	$(h) "make main-o-order"
	$(h) "   # ld同一组不同顺序的o文件,生成不同(MD5不一样)但功能一样"
	$(h) "   # 的目标文件.说明ld一组o文件,它们的先后顺序并没有影响生"
	$(h) "   # 成目标文件."
	$(nl)
	$(h) "make main-a-order-0 AORDER=1"
	$(h) "   # 能够编译成功; "
	$(h) "make main-a-order-1 AORDER=1"
	$(h) "   # 编译失败,原因是ld不能向前回溯,导致liba.a找不到show_init "
	$(h) "   # 符号信息.也就是说ld对a文件有先后顺序的要求!"
	$(h) "   # "
