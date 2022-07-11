import { HttpHeaders, HttpClient } from '@angular/common/http';
import { Component, OnInit } from '@angular/core';
import { Router, ActivatedRoute } from '@angular/router';
import { CookieService } from 'ngx-cookie-service';
import Swal from 'sweetalert2'

@Component({
  selector: 'app-register',
  templateUrl: './register.component.html',
  styleUrls: ['./register.component.scss']
})
export class RegisterComponent implements OnInit {

  constructor(private router: Router,
              private cookieService: CookieService,
              private http: HttpClient) { }

  ngOnInit(): void {
  }

  onRegister(e) {
    e.preventDefault();
    
    var correo = (<HTMLInputElement>document.getElementById("Email")).value;
    var psw = (<HTMLInputElement>document.getElementById("Password")).value;
    //si elementos vacios
    if (correo == "" || psw == "") {
      Swal.fire({
        title: 'Error!',
        text: 'Debes rellenar todos los campos',
        icon: 'warning',
        confirmButtonText: 'Ok'
      })
    }
    else {
      //consulta api
      const headers = new HttpHeaders({ "key": "Content-Type", "value": "application/json" })
      const body = '{"email": "test2@example.com","password": "test123","role": "User"}';
      this.http.post<{ name: string }>(
        'https://0atdirhknj.execute-api.us-east-1.amazonaws.com/dev/register',
        body, { headers: headers }).subscribe((res) => {
          console.log(res);
          var usrC = false;
          var pswc = false;
          
          //si datos malos
          if (!usrC && !pswc) {
            Swal.fire({
              title: 'Error!',
              text: 'Usuario o contraseña incorrectos',
              icon: 'error',
              confirmButtonText: 'Ok'
            })
          }
          //login correcto
          else  {
            localStorage.setItem('isLoggedin', 'true');
            this.cookieService.set('Role', 'User');
            this.cookieService.set('Token', 'Hello World');
            this.cookieService.set('Mail', correo);
            Swal.fire({
              title: 'Error!',
              text: 'Usario creado con éxito',
              icon: 'success',
              confirmButtonText: 'Ok'
            })
            this.router.navigate(['/dashboard']);
          }


       }

        );
        this.cookieService.set('Mail', correo);
        localStorage.setItem('isLoggedin', 'true');
        this.router.navigate(['/dashboard']);



  }

}
}
