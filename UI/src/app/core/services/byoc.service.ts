import { Injectable } from '@angular/core';
import { HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';

import { ApiService } from './api.service';
import { map } from 'rxjs/operators';

@Injectable({
  providedIn: 'root'
})
export class ByocService {
  constructor(
    private apiService: ApiService
  ) { }

  get(): Observable<any> {
    return this.apiService.get('')
      .pipe(map(data => data));
  }
}
