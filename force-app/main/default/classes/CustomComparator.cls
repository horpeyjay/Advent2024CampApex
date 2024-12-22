// Custom comparator class
public class CustomComparator implements Comparator<String> {
    private Map<String, Integer> flavorCount;

    // Constructor to initialize the frequency map
    public CustomComparator(Map<String, Integer> flavorCount) {
        this.flavorCount = flavorCount;
    }

    public Integer compare(String a, String b) {
        Integer freqA = flavorCount.get(a);
        Integer freqB = flavorCount.get(b);

        if (freqA == freqB) {
            // Sort alphabetically if frequencies are equal
            return a.compareTo(b);
        }
        // Sort by frequency in descending order
        return freqB - freqA;
    }
}