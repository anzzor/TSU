class Backpack:
    


    def add(self, item):
        print("В рюкзак положили", item)
        self.content = item

my_backpack = Backpack()
my_backpack.add('ноутбук')


my_son_backpack = Backpack()
my_son_backpack.add('учебник')
