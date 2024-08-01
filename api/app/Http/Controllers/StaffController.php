<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use App\Models\Staff;
use App\Models\Orders;
use Illuminate\Support\Facades\Hash;
use Illuminate\Support\Facades\Validator;
use Illuminate\Support\Facades\Session;

class StaffController extends Controller
{
    public function getAllStaff()
    {
        $staff = Staff::all();

        if ($staff->isEmpty()) {
            return response()->json([
                'success' => true,
                'message' => 'Tidak ada data staf ditemukan.',
                'staff' => []
            ], 404);
        }

        return response()->json([
            'success' => true,
            'staff' => $staff,
        ], 200);
    }

    public function signin(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'StaffName' => 'required|string',
            'Password' => 'required|string',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Validasi gagal.',
                'errors' => $validator->errors()
            ], 422);
        }

        $staff = Staff::where('StaffName', $request->StaffName)->first();

        if (!$staff || !Hash::check($request->Password, $staff->Password)) {
            return response()->json([
                'success' => false,
                'message' => 'Username atau password salah.',
            ], 401);
        }

        return response()->json([
            'success' => true,
            'message' => 'Berhasil masuk.',
            'staff' => $staff
        ], 200);
    }

    public function verifyEmail(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'Email' => 'required|email|exists:Staff,Email',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Email tidak ditemukan di database.',
                'errors' => $validator->errors()
            ], 404);
        }

        return response()->json([
            'success' => true,
            'message' => 'Email terverifikasi. Anda dapat melanjutkan untuk mereset kata sandi.',
        ], 200);
    }

    public function resetPassword(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'email' => 'required|email|exists:Staff,Email',
            'password' => 'required|string|confirmed|min:8',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Validasi gagal.',
                'errors' => $validator->errors()
            ], 422);
        }

        $staff = Staff::where('Email', $request->email)->first();

        if (!$staff) {
            return response()->json([
                'success' => false,
                'message' => 'Staf tidak ditemukan.',
            ], 404);
        }

        $staff->Password = Hash::make($request->password);
        $staff->save();

        return response()->json([
            'success' => true,
            'message' => 'Kata sandi telah direset. Anda sekarang dapat masuk.',
        ], 200);
    }

    public function getAdminData(Request $request)
    {
        $staff = Staff::find($request->input('StaffID'));

        if ($staff && $staff->Level === 'ADMIN') {
            return response()->json([
                'status' => true,
                'message' => 'Data untuk ADMIN',
                'data' => $this->getAdminSpecificData()
            ], 200);
        } else {
            return response()->json([
                'status' => false,
                'message' => 'Akses ditolak, bukan ADMIN'
            ], 403);
        }
    }

    public function getShipperData(Request $request)
    {
        $staff = Staff::find($request->input('StaffID'));

        if ($staff && $staff->Level === 'SHIPPER') {
            return response()->json([
                'status' => true,
                'message' => 'Data untuk SHIPPER',
                'data' => $this->getShipperSpecificData()
            ], 200);
        } else {
            return response()->json([
                'status' => false,
                'message' => 'Akses ditolak, bukan SHIPPER'
            ], 403);
        }
    }

    private function getAdminSpecificData()
    {
        return [
            'info' => 'Ini adalah data untuk ADMIN',
        ];
    }

    private function getShipperSpecificData()
    {
        return [
            'info' => 'Ini adalah data untuk SHIPPER',
        ];
    }

    public function signout(Request $request)
    {
        // Menghapus semua data sesi untuk logout
        Session::flush();

        return response()->json([
            'success' => true,
            'message' => 'Berhasil keluar.',
        ], 200);
    }

    public function updateProfile(Request $request)
    {
        // Validasi input
        $validator = Validator::make($request->all(), [
            'StaffID' => 'required|exists:Staff,StaffID',
            'StaffName' => 'required|string|max:255',
            'Email' => 'required|email|unique:Staff,Email,' . $request->StaffID . ',StaffID',
            // Tambahkan aturan validasi lainnya jika diperlukan
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Validasi gagal.',
                'errors' => $validator->errors()
            ], 422);
        }

        // Temukan staf berdasarkan ID
        $staff = Staff::find($request->StaffID);

        if (!$staff) {
            return response()->json([
                'success' => false,
                'message' => 'Staf tidak ditemukan.',
            ], 404);
        }

        // Update data staf
        $staff->StaffName = $request->StaffName;
        $staff->Email = $request->Email;
        // Tambahkan pembaruan untuk kolom lain jika diperlukan

        $staff->save();

        return response()->json([
            'success' => true,
            'message' => 'Profil berhasil diperbarui.',
            'data' => $staff
        ], 200);
    }

    public function acceptOrder(Request $request, $orderId)
    {
        // Validasi input
        $validator = Validator::make($request->all(), [
            'StaffID' => 'required|exists:Staff,StaffID',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Validasi gagal.',
                'errors' => $validator->errors()
            ], 422);
        }

        // Temukan staf dan periksa levelnya
        $staff = Staff::find($request->StaffID);

        if (!$staff || $staff->Level !== 'ADMIN') {
            return response()->json([
                'success' => false,
                'message' => 'Akses ditolak, bukan ADMIN'
            ], 403);
        }

        // Temukan order dan ubah statusnya
        $order = Orders::find($orderId);

        if (!$order) {
            return response()->json([
                'success' => false,
                'message' => 'Order tidak ditemukan.',
            ], 404);
        }

        $order->status = 'accepted'; // Ubah status sesuai kebutuhan
        $order->save();

        return response()->json([
            'success' => true,
            'message' => 'Order berhasil diterima.',
            'data' => $order
        ], 200);
    }

    public function rejectOrder(Request $request, $orderId)
    {
        // Validasi input
        $validator = Validator::make($request->all(), [
            'StaffID' => 'required|exists:Staff,StaffID',
        ]);

        if ($validator->fails()) {
            return response()->json([
                'success' => false,
                'message' => 'Validasi gagal.',
                'errors' => $validator->errors()
            ], 422);
        }

        // Temukan staf dan periksa levelnya
        $staff = Staff::find($request->StaffID);

        if (!$staff || $staff->Level !== 'ADMIN') {
            return response()->json([
                'success' => false,
                'message' => 'Akses ditolak, bukan ADMIN'
            ], 403);
        }

        // Temukan order dan ubah statusnya
        $order = Orders::find($orderId);

        if (!$order) {
            return response()->json([
                'success' => false,
                'message' => 'Order tidak ditemukan.',
            ], 404);
        }

        $order->status = 'CANCELLED'; // Ubah status sesuai kebutuhan
        $order->save();

        return response()->json([
            'success' => true,
            'message' => 'Order berhasil ditolak.',
            'data' => $order
        ], 200);
    }
}