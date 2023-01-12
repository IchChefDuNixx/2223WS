public class Hiker {
    private String name;
    private Item[] backpack;

    Hiker() {
        this("default");
    }

    Hiker(String name) {
        this(name, new Item[0]);
    }

    Hiker(String name, Item[] backpack) {
        this.name = name;
        this.backpack = backpack;
    }

    public String getName() {
        return this.name;
    }

    public double getBackpackweight() {
        double d = 0.0;
        if (this.backpack.length == 0) {
            return d;
        }
        for (int i = 0; i < this.backpack.length; i++) {
            d += this.backpack[i].getWeight();
        }
        return d;
    }

    public void pack(Item a) {
        Item[] newBackpack = new Item[this.backpack.length + 1];
        for (int i = 0; i < backpack.length; i++) {
            newBackpack[i] = backpack[i];
        }
        newBackpack[newBackpack.length - 1] = a;
        this.backpack = newBackpack;
    }

    public Item[] empty() {
        Item[] ground = new Item[this.backpack.length];
        for (int i = 0; i < this.backpack.length; i++) {
            ground[i] = this.backpack[i];
        }
        this.backpack = new Item[0];
        return ground;
    }

    public String getBackpackContent() {
        String s = "";
        for (Item item : this.backpack) {
            s += item.getName() + ", "; // not fancy
        }
        return s;
    }

    public int getBackpacklenght() {
        return this.backpack.length;
    }

    public String toString() {
        return "The Hiker " + name + " carries " + getBackpackContent() + " (" + getBackpackweight() + ").";

    }

}
