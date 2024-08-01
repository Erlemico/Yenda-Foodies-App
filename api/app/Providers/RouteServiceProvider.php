<?php

namespace App\Providers;

use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Hash;

class RouteServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     */
    public function register(): void
    {
        //
    }

    /**
     * Bootstrap any application services.
     */
    public function boot(): void
    {
        Route::middleware('api')
            ->prefix('api')
            ->group(base_path('routes/api.php'));

        Route::middleware('web')
            ->group(base_path('routes/web.php'));
    }
    public function testSave()
{
    $staff = new \App\Models\Staff();
    $staff->StaffID = '123';
    $staff->StaffName = 'John Doe';
    $staff->Email = 'john.doe@example.com';
    $staff->Password = Hash::make('password');
    $staff->save();

    return response()->json(['message' => 'Staff saved successfully'], 200);
}

}