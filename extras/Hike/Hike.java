public class Hike {
    String destination;
    Hiker[] hikeGroup;

    Hike() {
        this("default");
    }

    Hike(String destination) {
        this(destination, new Hiker[0]);
    }

    Hike(String destination, Hiker[] hikeGroup) {
        this.destination = destination;
        this.hikeGroup = hikeGroup;
    }

    public String getDestination() {
        return this.destination;
    }

    public Hiker lightestHiker() {
        Hiker lightHiker = hikeGroup[0];
        for (int i = 1; i < hikeGroup.length; i++) {
            if (hikeGroup[i].getBackpackweight() < lightHiker.getBackpackweight()) {
                lightHiker = hikeGroup[i];
            }
        }
        return lightHiker;
    }

    public Item[] sort(Item[] input) {
        boolean sorted = true;
        do {
            sorted = true;
            for (int i = 0; i < input.length - 1; i++) {
                if (input[i].getWeight() < input[i + 1].getWeight()) {
                    sorted = false;
                    Item temp = input[i];
                    input[i] = input[i + 1];
                    input[i + 1] = temp;
                }
            }
        } while (sorted == false);
        return input;
    }

    public void distribution() {
        Hiker tempHiker = new Hiker("shorty");
        for (Hiker person : hikeGroup) {
            for (Item thingy : person.empty()) {
                tempHiker.pack(thingy);
            }
        }
        Item[] itemPool = tempHiker.empty();
        // use comparable and collections
        itemPool = sort(itemPool);
        for (Item poolItem : itemPool) {
            lightestHiker().pack(poolItem);
        }
    }

    public String toString() { // maybe?
        String result = "";
        for (int i = 0; i < hikeGroup.length; i++) {
            System.out.println(hikeGroup[i].getName() + " " + hikeGroup[i].getBackpackweight());
        }
        return result;
    }

}
