const User = require('../Models/Users');
const { upload } = require('../Services/ImagesServices'); // Kiểm tra đường dẫn tới file upload
const port = "8080"

// Middleware tải lên hình ảnh
exports.uploadImage = upload.single('image'); // Thêm dòng này

// Lấy thông tin của người dùng hiện tại
exports.getCurrentUser = (req, res) => {
  res.status(200).json(req.user); // Gửi thông tin người dùng hiện tại
};

// Cập nhật thông tin của người dùng hiện tại
exports.updateCurrentUser = async (req, res) => {
  const userId = req.user._id;
  const updateData = { ...req.body }; 

  // Kiểm tra nếu có hình ảnh đã được tải lên
  if (req.file) {
    updateData.image = `http://192.168.1.7:${port}/uploads/${req.file.filename}`;
  }

  try {

    const updatedUser = await User.findByIdAndUpdate(userId, updateData, { new: true, select: '-__v' });

    if (!updatedUser) {
      return res.status(404).json({ message: 'Không tìm thấy người dùng' });
    }


    res.status(200).json({
      message: 'Cặp nhật thông tin thành công',
      user: updatedUser,
    });
  } catch (error) {
    res.status(500).json({ message: 'Lỗi cặp nhật', error: error });
  }
};

// Lấy thông tin của tất cả người dùng (chỉ admin)
exports.getAllUsers = async (req, res) => {
  try {

    const users = await User.find().select('-__v');

    if (users.length === 0) {
      return res.status(204).json({ message: 'Không tìm thấy người dùng nào' });
    }

    res.status(200).json({
      message: 'Người dùng đã được tìm thấy',
    });

  } catch (error) {
    console.error('Lỗi truy xuất người dùng :', error);
    res.status(500).json({ message: 'Lỗi khi truy xuất người dùng', error: error.message });
  }
};


// Cập nhật thông tin người dùng theo ID (chỉ admin)
exports.updateUserById = async (req, res) => {
  const userId = req.params.id; // ID người dùng từ tham số

  try {
    const updatedUser = await User.findByIdAndUpdate(userId, req.body, { new: true, select: '-__v' });
    if (!updatedUser) {
      return res.status(404).json({ message: 'Không tìm thấy người dùng' });
    }
    res.status(200).json({
      message: 'Cặp nhật thông tin thành công',
      user: updatedUser,
    });
  } catch (error) {
    res.status(500).json({ message: 'Lỗi cặp nhật người dùng', error: error });
  }
};

// Xóa người dùng (chỉ admin)
exports.deleteUserById = async (req, res) => {
  const userId = req.params.id; // ID người dùng từ tham số
  try {
    const deletedUser = await User.findByIdAndDelete(userId);
    if (!deletedUser) {
      return res.status(404).json({ message: 'không tìm thấy người dùng' });
    }
    res.status(200).json({ message: 'Xóa người dùng thành công' });
  } catch (error) {
    res.status(500).json({ message: 'Lỗi xóa người dùng', error: error });
  }
};