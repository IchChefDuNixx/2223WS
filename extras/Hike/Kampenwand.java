public class Kampenwand {
    public static void main(String[] args) {

        Item a = new Item("RedBull", 330);
        Item b = new Item("nLiterWasser", 1000);
        Item c = new Item("Brotzeitbox", 350);
        Item d = new Item("nHalbenLiterWasser", 500);
        Item e = new Item("n3/4LiterWasser", 750);
        Item f = new Item("n1/4LiterWasser", 250);
        Item g = new Item("n1/8LiterWasser", 125);

        Hiker anton = new Hiker("Anton", new Item[] {});
        Hiker berta = new Hiker("Berta", new Item[] { e, e, f, b, c });
        Hiker carl = new Hiker("Carl", new Item[] { c, d, g, f });
        Hiker dora = new Hiker("Dora", new Item[] { a, a, g, d, f });

        Hike trip = new Hike("Kampenwand", new Hiker[] { anton, berta, carl, dora });

        System.out.println(trip);
        trip.distribution();
        System.out.println(trip);
    }
}
