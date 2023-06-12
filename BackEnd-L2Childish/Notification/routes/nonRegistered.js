const express = require('express');
const router = require('express').Router();
const group = require('../models/group');
const group1 = require('../models/group1');
const Donation = require('../models/donation');

router.get('/', (req, res) => {
    Promise.all([
      Donation.aggregate([
        {
          $match:{
            id:null,
          } , 
        },
        {
          $group: {
            _id: '$email',
            count: { $sum: 1 },
          },
        },
        {
          $group: {
            _id: null,
            totalCount: { $sum: 1 },
          },
        },
      ]).exec(),
      group.aggregate([
        {
          $group: {
            _id: '$email',
            count: { $sum: 1 },
          },
        },
        {
          $group: {
            _id: null,
            totalCount: { $sum: 1 },
          },
        },
      ]).exec(),
      group1.aggregate([
        {
          $group: {
            _id: '$email',
            count: { $sum: 1 },
          },
        },
        {
          $group: {
            _id: null,
            totalCount: { $sum: 1 },
          },
        },
      ]).exec(),
    ])
      .then((results) => {
        const totalCount = results.reduce((sum, result) => sum + (result[0]?.totalCount || 0), 0);
        console.log('Total count:', totalCount);
        res.status(200).send(totalCount.toString());
      })
      .catch((error) => {
        console.error('Failed to get the total count:', error);
        res.status(500).send('An error occurred');
      });
  });

  module.exports=router;