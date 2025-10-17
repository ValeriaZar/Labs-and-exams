import java.io.*;
import java.util.*;

public class Main {
    private static int size = 0;

    public static class ListElem implements Iterable<Integer> {
        private static class ListNode {
            public Integer value;
            public ListNode next;

            public ListNode(Integer newValue) {
                this.value = newValue;
                this.next = null;
            }
        }

        public Integer size;
        public ListNode head;

        public ListElem() {
            this.head = null;
            this.size = 0;
        }

        public void add(Integer newValue) {
            ListNode newNode = new ListNode(newValue);
            if (head == null || head.value >= newValue) {
                newNode.next = head;
                head = newNode;
            } else {
                ListNode current = head;
                while (current.next != null && current.next.value < newValue)
                    current = current.next;
                newNode.next = current.next;
                current.next = newNode;
            }
            size++;
        }

        public Iterator<Integer> iterator() {
            return new Iterator<>() {
                private ListNode current = head;

                @Override
                public boolean hasNext() {
                    return current != null;
                }

                @Override
                public Integer next() {
                    Integer value = current.value;
                    current = current.next;
                    return value;
                }
            };
        }
    }

    private static final Scanner scan = new Scanner(System.in);
    static Node treeFirst = null;
    static ListElem lastElemlist;
    static ListElem centralElemlist;
    private final static int MAX_VALUE = 300;
    private final static int MIN_VALUE = 1;
    private static final int MAX_SIZE = 20;
    private static final String RESET = "\u001B[0m";
    private static final String RED = "\033[91;1m";
    private static final String CYAN_BOLD = "\033[38;2;0;255;255m";
    private static final String GRAY = "\033[38;2;96;96;96m";
    private static final String GREEN = "\033[38;2;173;255;47m";

    public static void main(String[] args) {
        chooseOption();
        scan.close();
    }

    private static void chooseOption() {
        int choice;
        System.out.println("Find the path of minimum length between roots and leaves and the central vertices of these paths. Visualize trees before and after in different windows.\nThe range of tree element values is from " + CYAN_BOLD + MIN_VALUE + RESET + " to " + CYAN_BOLD + MAX_VALUE + RESET + "\nYou cant't enter more than " + CYAN_BOLD + MAX_SIZE + RESET + " elements");
        do {
            choice = menu();
            switch (choice) {
                case 1:
                    addElements();
                    break;
                case 2:
                    createEmptyTree();
                    break;
                case 3:
                    deleteElements();
                    break;
                case 4:
                    findAndPrintMinWay();
                    break;
                case 5:
                    removeCentralVertices();
                    break;
                case 6:
                    loadFromFile();
                    break;
                case 7:
                    saveToFile();
                    break;
                case 8:
                    viewTree();
                    break;
            }
        } while (choice != 0);
    }

    private static void createEmptyTree() {
        treeFirst = null;
        System.out.println(CYAN_BOLD + "Empty tree" + RESET + " has been created.");
        size = 0;
    }

    private static void viewTree() {
        if (treeFirst == null)
            System.out.println(RED + "Tree not created!" + RESET + " Add elements first.");
        else {
            System.out.println("Current state of the tree:");
            System.out.println("-----------------------------------------------------------------");
            printTree(treeFirst, null, false);
            System.out.println("-----------------------------------------------------------------");
        }
    }

    private static void addElements() {
        if (size >= MAX_SIZE) {
            System.out.println(RED + "Maximum number of elements reached (" + MAX_SIZE + "). You cannot add more." + RESET);
            return;
        }
        System.out.println("Enter the element from " + CYAN_BOLD + MIN_VALUE + RESET + " to " + CYAN_BOLD + MAX_VALUE + RESET + " you want to add to the tree or type '" + CYAN_BOLD + "stop" + RESET + "' to end:");
        while (size < MAX_SIZE) {
            String input = scan.nextLine().trim();
            if (input.equalsIgnoreCase("stop"))
                return;
            else if (isValidNumber(input)) {
                int m = Integer.parseInt(input);
                System.out.println("-----------------------------------------------------------------");
                treeFirst = add(m, treeFirst);
                printTree(treeFirst, null, true);
                System.out.println("-----------------------------------------------------------------");
            } else
                System.out.println(RED + "Invalid input!" + RESET + " Please enter a number from " + CYAN_BOLD + MIN_VALUE + RESET + " to " + CYAN_BOLD + MAX_VALUE + RESET + " or type '" + CYAN_BOLD + "stop" + RESET + "' to finish.");
        }
        if (size >= MAX_SIZE)
            System.out.println(RED + "Maximum number of elements reached (" + MAX_SIZE + "). You cannot add more." + RESET);
    }

    private static boolean isValidNumber(String input) {
        if (!input.matches("[1-9]\\d{0,2}"))
            return false;
        try {
            int number = Integer.parseInt(input);
            return number >= MIN_VALUE && number <= MAX_VALUE;
        } catch (NumberFormatException e) {
            return false;
        }
    }

    private static boolean existsInTree(Node treeStart, int value) {
        if (treeStart == null)
            return false;
        if (treeStart.data == value)
            return true;
        return existsInTree(treeStart.nextLeft, value) || existsInTree(treeStart.nextRight, value);
    }

    private static void deleteElements() {
        if (treeFirst == null) {
            System.out.println(RED + "Tree not created!" + RESET + " Add elements first.");
            return;
        }
        System.out.println("Current state of the tree:");
        System.out.println("-----------------------------------------------------------------");
        printTree(treeFirst, null, false);
        System.out.println("-----------------------------------------------------------------");
        System.out.println("Enter the element you want to remove from the tree or type '" + CYAN_BOLD + "stop" + RESET + "' to finish:");
        String input = scan.nextLine().trim();
        while (!input.equalsIgnoreCase("stop")) {
            if (isValidNumber(input)) {
                int n = Integer.parseInt(input);
                if (!existsInTree(treeFirst, n)) {
                    System.out.println("Element" + RED + " not found" + RESET + " in the tree!");
                } else {
                    System.out.println("-----------------------------------------------------------------");
                    treeFirst = delete(n, treeFirst);
                    if (treeFirst == null) {
                        System.out.println("The tree is now" + CYAN_BOLD + " empty" + RESET + "!");
                        return;
                    }
                    printTree(treeFirst, null, false);
                    System.out.println("-----------------------------------------------------------------");
                }
            } else
                System.out.println(RED + "Invalid input!" + RESET + " Please enter a number from " + CYAN_BOLD + MIN_VALUE + RESET + " to " + CYAN_BOLD + MAX_VALUE + RESET + " or type '" + CYAN_BOLD + "stop" + RESET + "' to finish.");
            input = scan.nextLine().trim();
        }
    }

    private static void findAndPrintMinWay() {
        if (treeFirst == null) {
            System.out.println(RED + "Tree not created!" + RESET + " Add elements first.");
            return;
        }
        int wayLength = findMinWay(treeFirst) - 1;
        if (wayLength < 1)
            System.out.println("Unable to determine the minimum path! Add tree nodes and try again.");
        else
            System.out.println("Minimum path length: " + CYAN_BOLD + wayLength + RESET);
    }

    private static void removeCentralVertices() {
        if (treeFirst == null) {
            System.out.println(RED + "Tree not created!" + RESET + " Add elements first.");
            return;
        }
        if (size == 1) {
            treeFirst = null;
            size--;
            System.out.println("The tree is now empty after removing the central node.");
            return;
        }
        System.out.println("Tree" + CYAN_BOLD + " before " + RESET + "removing central nodes of minimum paths:");
        System.out.println("-----------------------------------------------------------------");
        printTree(treeFirst, null, false);
        System.out.println("-----------------------------------------------------------------");
        int minWayLength = findMinWay(treeFirst);
        if (minWayLength % 2 == 1) {
            lastElemlist = new ListElem();
            centralElemlist = new ListElem();
            getAllLeafsOnMinWays(treeFirst, minWayLength);
            for (int value : lastElemlist)
                getCentralVertexOnMinWays(treeFirst, value, (minWayLength + 1) / 2);
            for (int value : centralElemlist) {
                treeFirst = delete(value, treeFirst);
                size--;
            }
        }
        System.out.println("The tree" + CYAN_BOLD + " after" + RESET + " removing the central nodes of the minimum paths:");
        System.out.println("-----------------------------------------------------------------");
        printTree(treeFirst, null, false);
        System.out.println("-----------------------------------------------------------------");
    }

    private static void loadFromFile() {
        boolean isFileIncorrect;
        String filePath;
        File inputFile;
        do {
            System.out.println("Enter the path to the file with the extension(in the file should be no more than " + CYAN_BOLD + MAX_SIZE + RESET + " elements, elements must be in the range from " + CYAN_BOLD + MIN_VALUE + RESET + " to " + CYAN_BOLD + MAX_VALUE + RESET + "):");
            filePath = scan.nextLine();
            inputFile = new File(filePath);
            isFileIncorrect = !checkFile(inputFile);
        } while (isFileIncorrect);
        inputFromFile(inputFile);
        printTree(treeFirst, null, false);
    }

    private static void saveToFile() {
        if (treeFirst == null) {
            System.out.println(RED + "Tree not created!" + RESET + " Add elements first.");
            return;
        }
        String path = getValidFilePath();
        String treeData = treeToString(treeFirst);
        try (FileWriter writer = new FileWriter(path)) {
            writer.write(treeData);
            System.out.println("Tree saved to file" + CYAN_BOLD + " successfully" + RESET + ".");
        } catch (IOException e) {
            System.out.println(RED + "Error saving tree to file: " + RESET + e.getMessage());
        }
    }

    private static void getAllLeafsOnMinWays(Node treeStart, int minWayLength) {
        if (treeStart != null) {
            if ((minWayLength == 1) && (treeStart.nextLeft == null) && (treeStart.nextRight == null))
                lastElemlist.add(treeStart.data);
            else {
                getAllLeafsOnMinWays(treeStart.nextLeft, minWayLength - 1);
                getAllLeafsOnMinWays(treeStart.nextRight, minWayLength - 1);
            }
        }
    }

    private static boolean hasListThisElem(ListElem list, int elemValue) {
        for (int value : list)
            if (value == elemValue)
                return true;
        return false;
    }

    private static void getCentralVertexOnMinWays(Node treeStart, final int value, int minWayLength) {
        if (treeStart != null) {
            if ((minWayLength == 1) && !hasListThisElem(centralElemlist, treeStart.data))
                centralElemlist.add(treeStart.data);
            else {
                if (value < treeStart.data)
                    getCentralVertexOnMinWays(treeStart.nextLeft, value, minWayLength - 1);
                else
                    getCentralVertexOnMinWays(treeStart.nextRight, value, minWayLength - 1);
            }
        }
    }

    private static int inputInt(int min, int max) {
        int num = 0;
        boolean isNotCorrect;
        do {
            isNotCorrect = false;
            String input = scan.nextLine().trim();
            if (input.matches("^(0\\d+)$")) {
                System.out.println(RED + "Leading zeros are not allowed!" + RESET + " Try again:");
                isNotCorrect = true;
            } else {
                try {
                    num = Integer.parseInt(input);
                } catch (NumberFormatException e) {
                    System.out.println(RED + "You have entered incorrect data!" + RESET + " Try again:");
                    isNotCorrect = true;
                }
                if (!isNotCorrect && (num < min || num > max)) {
                    System.out.println(RED + "The value entered is not within the range of acceptable values!" + RESET + " Try again:");
                    isNotCorrect = true;
                }
            }
        } while (isNotCorrect);
        return num;
    }

    private static int menu() {
        boolean treeExists = (treeFirst != null);
        boolean treeFull = (size >= MAX_SIZE);
        System.out.println("-----------------------------------------------------------------");
        System.out.println((treeFull ? GRAY : GREEN) + "1. Add an element to the tree." + RESET);
        System.out.println(GREEN + "2. Create empty tree." + RESET);
        System.out.println((treeExists ? GREEN : GRAY) + "3." + (treeExists ? "" : " (Unavailable)") + " Remove an element from the tree." + RESET);
        System.out.println((treeExists ? GREEN : GRAY) + "4." + (treeExists ? "" : " (Unavailable)") + " Find the length of the minimum path from the root of the tree to its leaves." + RESET);
        System.out.println((treeExists ? GREEN : GRAY) + "5." + (treeExists ? "" : " (Unavailable)") + " Remove the central nodes of minimum paths." + RESET);
        System.out.println(GREEN + "6. Import a tree from a file." + RESET);
        System.out.println((treeExists ? GREEN : GRAY) + "7." + (treeExists ? "" : " (Unavailable)") + " Save the current tree to a file." + RESET);
        System.out.println((treeExists ? GREEN : GRAY) + "8." + (treeExists ? "" : " (Unavailable)") + " View tree." + RESET);
        System.out.println(GREEN + "0. Exit." + RESET);
        System.out.println("-----------------------------------------------------------------");
        System.out.print("Enter the menu item number: ");
        return inputInt(0, 8);
    }

    private static void showTrunks(Trunk p) {
        if (p != null) {
            showTrunks(p.prev);
            System.out.print(p.str);
        }
    }

    private static void printTree(Node root, Trunk prev, boolean isLeft) {
        if (root != null) {
            String prev_str = "    ";
            Trunk trunk = new Trunk(prev, prev_str);
            printTree(root.nextRight, trunk, true);
            if (prev == null)
                trunk.str = CYAN_BOLD + "———" + RESET;
            else if (isLeft) {
                trunk.str = CYAN_BOLD + "╭──" + RESET;
                prev_str = CYAN_BOLD + "    |";
            } else {
                trunk.str = CYAN_BOLD + "╰──" + RESET;
                prev.str = prev_str;
            }
            showTrunks(trunk);
            System.out.println(" " + root.data);
            if (prev != null)
                prev.str = prev_str;
            trunk.str = CYAN_BOLD + "    |" + RESET;
            printTree(root.nextLeft, trunk, false);
        }
    }

    private static void inputFromFile(File file) {
        int n;
        treeFirst = null;
        try (Scanner fileScan = new Scanner(file)) {
            while (fileScan.hasNext()) {
                n = fileScan.nextInt();
                treeFirst = add(n, treeFirst);
            }

        } catch (IOException e) {
            System.out.println(RED + "Failed to read data from file!" + RESET);
        }
    }

    private static boolean checkFile(File file) {
        int elementCount = 0;
        if (!file.exists()) {
            System.out.println("The file" + RED + " does not exist" + RESET + " at the specified path!");
            return false;
        }
        if (file.isDirectory()) {
            System.out.println("The specified path" + RED + " is a directory" + RESET + ", not a file!");
            return false;
        }
        if (!file.getName().toLowerCase().endsWith(".txt")) {
            System.out.println(RED + "Invalid file format!" + RESET + " The file must have a" + CYAN_BOLD + " .txt" + RESET + " extension.");
            return false;
        }
        if (file.length() == 0) {
            System.out.println(RED + "The file is empty!" + RESET);
            return false;
        }
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line = reader.readLine();
            if (line == null && !file.exists()) {
                System.out.println("The file" + RED + " cannot be read." + RESET + " Please check file permissions.");
                return false;
            }
        } catch (IOException e) {
            System.out.println("The file" + RED + " cannot be read." + RESET + " Please check file permissions.");
            return false;
        }
        boolean isFileCorrect = true;
        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                line = line.trim();
                if (!line.isEmpty()) {
                    String[] numbers = line.split("\\s+");
                    for (String number : numbers) {
                        if (!isValidNumber(number)) {
                            System.out.println("Invalid data in file: " + RED + number + RESET + " (Not a valid number).");
                            isFileCorrect = false;
                        }
                        elementCount++;
                    }
                    if (elementCount > MAX_SIZE && isFileCorrect) {
                        isFileCorrect = false;
                        System.out.println(RED + "The file contains more than " + MAX_SIZE + " elements. Please reduce the number of elements in the file." + RESET);
                    }
                }
            }
        } catch (IOException e) {
            System.out.println(RED + "Error reading the file: " + RESET + e.getMessage());
            return false;
        }
        return isFileCorrect;
    }

    private static String getValidFilePath() {
        String path = "";
        boolean isValidFile = false;
        while (!isValidFile) {
            System.out.print("\nEnter the path to the file and its name with extension: ");
            path = scan.nextLine().trim();
            if (!path.endsWith(".txt"))
                System.out.println("The file must be with a" + CYAN_BOLD + " .txt" + RESET + " extension!");
            else {
                File file = new File(path);
                if (!file.exists()) {
                    try {
                        if (file.createNewFile()) {
                            System.out.println("File created" + CYAN_BOLD + " successfully" + RESET + ": " + CYAN_BOLD + path + RESET);
                            isValidFile = true;
                        } else
                            System.out.println(RED + "Error creating file." + RESET);
                    } catch (IOException e) {
                        System.out.println(RED + "Failed to create new file!" + RESET);
                    }
                } else {
                    try (FileWriter writer = new FileWriter(file, true)) {
                        writer.write("");
                        isValidFile = true;
                    } catch (IOException e) {
                        System.out.println(RED + "The file is not writable or has restricted permissions!" + RESET);
                    }
                }
            }
        }
        return path;
    }

    private static String treeToString(Node root) {
        if (root == null)
            return "";
        return root.data + "\n" + treeToString(root.nextLeft) + treeToString(root.nextRight);
    }

    private static int findMinWay(Node treeStart) {
        if (treeStart == null)
            return 0;
        else if ((treeStart.nextLeft == null) && (treeStart.nextRight == null))
            return 1;
        else if (treeStart.nextLeft == null)
            return 1 + findMinWay(treeStart.nextRight);
        else if (treeStart.nextRight == null)
            return 1 + findMinWay(treeStart.nextLeft);
        else {
            return 1 + Math.min(findMinWay(treeStart.nextLeft), findMinWay(treeStart.nextRight));
        }
    }

    private static Node findMinNodeInRightSubtree(Node startSubtree) {
        while (startSubtree.nextLeft != null)
            startSubtree = startSubtree.nextLeft;
        return startSubtree;
    }

    private static Node delete(int n, Node treeStart) {
        if (treeStart == null)
            return null;
        if (n < treeStart.data)
            treeStart.nextLeft = delete(n, treeStart.nextLeft);
        else if (n > treeStart.data)
            treeStart.nextRight = delete(n, treeStart.nextRight);
        else {
            if (treeStart.nextLeft == null && treeStart.nextRight == null) {
                size--;
                return null;
            } else if (treeStart.nextLeft == null) {
                size--;
                return treeStart.nextRight;
            } else if (treeStart.nextRight == null) {
                size--;
                return treeStart.nextLeft;
            } else {
                Node minNode = findMinNodeInRightSubtree(treeStart.nextRight);
                treeStart.data = minNode.data;
                treeStart.nextRight = delete(minNode.data, treeStart.nextRight);
            }
        }
        return balance(treeStart);
    }

    private static Node add(int n, Node treeStart) {
        if (treeStart == null) {
            size++;
            return new Node(n);
        }
        if (n < treeStart.data)
            treeStart.nextLeft = add(n, treeStart.nextLeft);
        else if (n > treeStart.data)
            treeStart.nextRight = add(n, treeStart.nextRight);
        return balance(treeStart);
    }

    private static int height(Node node) {
        return node == null ? 0 : node.height;
    }

    private static int balanceFactor(Node node) {
        return node == null ? 0 : height(node.nextLeft) - height(node.nextRight);
    }

    private static void updateHeight(Node node) {
        if (node != null)
            node.height = Math.max(height(node.nextLeft), height(node.nextRight)) + 1;
    }

    private static Node rotateRight(Node y) {
        Node x = y.nextLeft;
        Node T2 = x.nextRight;
        x.nextRight = y;
        y.nextLeft = T2;
        updateHeight(y);
        updateHeight(x);
        return x;
    }

    private static Node rotateLeft(Node x) {
        Node y = x.nextRight;
        Node T2 = y.nextLeft;
        y.nextLeft = x;
        x.nextRight = T2;
        updateHeight(x);
        updateHeight(y);
        return y;
    }

    private static Node balance(Node node) {
        if (node == null)
            return null;
        updateHeight(node);
        int balance = balanceFactor(node);
        if (balance > 1) {
            if (balanceFactor(node.nextLeft) < 0)
                node.nextLeft = rotateLeft(node.nextLeft);
            return rotateRight(node);
        }
        if (balance < -1) {
            if (balanceFactor(node.nextRight) > 0)
                node.nextRight = rotateRight(node.nextRight);
            return rotateLeft(node);
        }
        return node;
    }
}

class Node {
    public int data;
    public Node nextLeft;
    public Node nextRight;
    public int height;

    public Node(int n) {
        this.data = n;
        this.nextLeft = null;
        this.nextRight = null;
        this.height = 1;
    }
}

class Trunk {
    Trunk prev;
    String str;

    Trunk(Trunk prev, String str) {
        this.prev = prev;
        this.str = str;
    }
}