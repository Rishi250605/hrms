import { EmployeeCategory } from '../../generated/prisma/enums.js';
import type { DocumentType } from '../../generated/prisma/enums.js';

export const EMPLOYEE_CATEGORIES = Object.values(EmployeeCategory);

/**
 * Initial document requirements seeded into DocumentRequirement (HR edits them in the app).
 * DRIVER follows CLAUDE.md §6 (DL, PSV badge, medical).
 * TODO(business): confirm requirements for conductors, helpers, mechanics and depot staff.
 */
export const DEFAULT_DOCUMENT_REQUIREMENTS: Partial<Record<EmployeeCategory, DocumentType[]>> = {
  DRIVER: ['DRIVING_LICENCE', 'PSV_BADGE', 'MEDICAL_FITNESS'],
};
