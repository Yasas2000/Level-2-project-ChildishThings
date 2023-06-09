const mongoose = require('mongoose')

const edurequestSchema = mongoose.Schema(
    {   
        userId: {
            type: String,
            required: true
        },
        fullName: {
            type: String,
            required: [true, "Please enter your Full Name"]
        },
        telephoneNumber: {
            type: String,
            required: true,
            default: 0
        },
        email: {
            type: String,
            required: true
        },
        purpose: {
            type: String,
            required: true
        },
        instituteName: {
            type: String,
            required: true
        },
        instituteAddress: {
            type: String,
            required: true
        },
        instituteEmail: {
            type: String,
            required: true,
            match: /^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$/
        }
    },
    {
        timestamps: true
    }
);

module.exports = mongoose.model('edu_help_request', edurequestSchema);
