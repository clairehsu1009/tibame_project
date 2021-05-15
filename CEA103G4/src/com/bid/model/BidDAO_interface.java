package com.bid.model;

import java.util.List;


public interface BidDAO_interface {
    public void insert(BidVO bidVO);
    public void update(BidVO bidVO);
    public void delete(Integer bid_no);
    public BidVO findByPrimaryKey(Integer bid_no);
    public List<BidVO> getAll();
}
