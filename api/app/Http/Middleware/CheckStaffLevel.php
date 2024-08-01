<?php

namespace App\Http\Middleware;

use Closure;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class CheckStaffLevel
{
    /**
     * Handle an incoming request.
     */
    public function handle(Request $request, Closure $next, $level)
    {
        $staff = Auth::guard('staff')->user();

        if ($staff && $staff->Level === $level) {
            return $next($request);
        }

        return response()->json([
            'success' => false,
            'message' => 'Access denied. You do not have the required level.',
        ], 403);
    }
}