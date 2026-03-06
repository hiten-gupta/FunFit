package com.gms.model;

public class Batch {
    private int bid;
    private String name;
    private String slot;
    private String time;

    public Batch() {}

    public Batch(int bid, String name, String slot, String time) {
        this.bid = bid;
        this.name = name;
        this.slot = slot;
        this.time = time;
    }

    public int getBid() { return bid; }
    public void setBid(int bid) { this.bid = bid; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getSlot() { return slot; }
    public void setSlot(String slot) { this.slot = slot; }

    public String getTime() { return time; }
    public void setTime(String time) { this.time = time; }

    @Override
    public String toString() {
        return "Batch{bid=" + bid + ", name='" + name + "', slot='" + slot + "', time='" + time + "'}";
    }
}
