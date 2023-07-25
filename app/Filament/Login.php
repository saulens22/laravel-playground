<?php

namespace App\Filament;

use Filament\Facades\Filament;
use Illuminate\Support\Facades\Auth;
use Filament\Pages\Auth\Login as AuthLogin;

class Login extends AuthLogin
{
    public function mount(): void
    {
        Auth::loginUsingId(1);

        if (Filament::auth()->check()) {
            redirect()->intended(Filament::getUrl());
        }

        $this->form->fill();
    }
}
