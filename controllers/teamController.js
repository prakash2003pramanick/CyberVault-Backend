const Team = require('../models/Team');

exports.createTeam = async (req, res) => {
  const newTeam = new Team(req.body);
  try {
    const savedTeam = await newTeam.save();
    res.status(201).json(savedTeam);
  } catch (err) {
    res.status(500).json(err);
  }
};

// Additional team-related controllers can be added here
