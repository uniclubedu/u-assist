import { TestBed } from '@angular/core/testing';

import { ByocService } from './byoc.service';

describe('ByocService', () => {
  let service: ByocService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(ByocService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});
