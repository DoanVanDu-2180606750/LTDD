const mongoose = require('mongoose');

const roomSchema = new mongoose.Schema({
    name: {
        type: String,
        required: true
    },
    price: {
        type: Number,
        required: true
    },
    star: {
        type: Number,
        required: true,
        min: 0,
        max: 5
    },
    describe: {
        type: String,
        required: true
    },
    status: {
        type: Boolean,
        default: true // true nghĩa là còn trống
    },
    bed: {
        type: String,
        required: true
    },
    capacity: {
        type: Number,
        required: true
    },
    images: { // Dùng mảng để lưu trữ nhiều hình ảnh
        type: [String],
        default: []
    },
    room_type: {
        type: String,
        required: true
    },
    amenities: {
        type: [String], // Làm mảng để chứa nhiều tiện nghi
        default: []
    },
    location: {
        type: String,
        required: true
    },
    reviews: [{
        user: { type: String }, // Tên người đánh giá
        rating: { type: Number, min: 0, max: 5 }, // Điểm đánh giá
        comment: { type: String } // Nhận xét của người dùng
    }],
    created_at: {
        type: Date,
        default: Date.now
    },
    updated_at: {
        type: Date,
        default: Date.now
    },
    discount: {
        type: String,
        default: "0%" // Mặc định không có giảm giá
    }
});

// Tạo model Room từ schema
const Room = mongoose.model('Room', roomSchema);

module.exports = Room;
