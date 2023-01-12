public class pi {
    public static void main(String[] args) {
        double error = 1E-6;
        double sum = 0;
        int i = 1;
        while (error < Math.PI - Math.sqrt(sum)) {
            // System.out.println(error + "-" + (Math.PI - Math.sqrt((sum))));
            sum += 6 / Math.pow(i, 2);
            if (i % 100000 == 0) {
                System.out.println(i + "-" + Math.sqrt(sum));
            }
            i++;

        }
        System.out.println(i - 1);

    }
}
