public class Item {
    private String name;
    private double weight;

    Item() {
        this("default");
    }

    Item(String name) {
        this(name, 0);

    }

    Item(String name, double weight) {
        this.name = name;
        this.weight = weight;
    }

    public String getName() {
        return this.name;
    }

    public double getWeight() {
        return this.weight;
    }

    @Override
    public String toString() {
        return this.name + " & has the weight of " + this.weight + "g";
    }
}
