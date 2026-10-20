package com.shopsphere.network.server;

import com.shopsphere.network.model.Product;
import java.io.*;
import java.net.*;
import java.util.*;

public class InventoryServer {
    static List<Product> p = List.of(new Product(1, "Headphones", 2499, 25), new Product(2, "Smart Watch", 3999, 18),
            new Product(3, "Keyboard", 2999, 30));

    public static void main(String[] x) throws Exception {
        try (ServerSocket s = new ServerSocket(5050)) {
            System.out.println("Inventory Server: port 5050");
            while (true)
                try (Socket c = s.accept()) {
                    BufferedReader in = new BufferedReader(new InputStreamReader(c.getInputStream()));
                    ObjectOutputStream out = new ObjectOutputStream(c.getOutputStream());
                    String q = in.readLine();
                    out.writeObject(q.startsWith("GET_STOCK") ? stock(q) : find(q));
                    out.flush();
                }
        }
    }

    static Object find(String q) {
        int id = Integer.parseInt(q.split(" ")[1]);
        return p.stream().filter(a -> a.id == id).findFirst().orElse(null);
    }

    static Object stock(String q) {
        int id = Integer.parseInt(q.split(" ")[1]);
        return p.stream().filter(a -> a.id == id).map(a -> a.stock).findFirst().orElse(0);
    }
}
