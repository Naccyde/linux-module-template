/*
# This file is part of linux-module-template.
#
# linux-module-template is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# linux-module-template is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with Foobar.  If not, see <http://www.gnu.org/licenses/>.
*/

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
