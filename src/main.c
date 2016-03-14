#include <linux/kernel.h>
#include <linux/module.h>

MODULE_LICENSE("GPL");
MODULE_AUTHOR("Quentin Deslandes");

static int __init ppinit_module(void)
{
	printk(KERN_INFO "Module inserted\n");
	return 0;
}

static void __exit ppexit_module(void)
{
	printk(KERN_INFO "Module removed\n");
}

module_init(ppinit_module);
module_exit(ppexit_module);
